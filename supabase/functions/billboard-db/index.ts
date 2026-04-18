/**
 * billboard-db / index.ts
 *
 * Strategy 1 — SQL Database
 * Saves every billboard fragment as a row in public.billboard_fragments.
 *
 * POST  /billboard-db           → upload (f22 / formesc / uppy auto-detected)
 * GET   /billboard-db           → list recent fragments (JSON)
 * GET   /billboard-db?name=...  → retrieve one fragment by name (returns raw content)
 *
 * Drop-in replacement for f22.php / formesc.php / uppy.php that outputs
 * the same plain-text filename on success.
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';


// ===========================================================================
// Embedded _shared files (cors.ts, random_hex.ts, parse_billboard.ts)
// ===========================================================================

// Shared CORS headers — mirrors PHP's open-CORS billboard behaviour.
export const corsHeaders: Record<string, string> = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type, x-user-id',
  'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
};

/** Wrap any response with CORS headers. */
export function cors(res: Response): Response {
  const headers = new Headers(res.headers);
  for (const [k, v] of Object.entries(corsHeaders)) headers.set(k, v);
  return new Response(res.body, { status: res.status, statusText: res.statusText, headers });
}

/** Preflight shortcut. */
export function preflight(): Response {
  return new Response('ok', { status: 200, headers: corsHeaders });
}

/** JSON error response. */
export function jsonError(msg: string, status = 500): Response {
  return new Response(JSON.stringify({ error: msg }), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}

/** JSON success response. */
export function jsonOk(data: unknown): Response {
  return new Response(JSON.stringify(data), {
    status: 200,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}

/** Plain-text response (matching PHP's echo behaviour). */
export function textOk(body: string): Response {
  return new Response(body, {
    status: 200,
    headers: { ...corsHeaders, 'Content-Type': 'text/plain' },
  });
}


/**
 * random_hex.ts
 * Crypto-random hex generator — equivalent to the PHP rand(0,255) loop that
 * builds 128-char hex filenames in f22.php / formesc.php.
 */

/** Returns a hex string of `bytes` random bytes (default 64 → 128 hex chars). */
export function randomHex(bytes = 64): string {
  const buf = new Uint8Array(bytes);
  crypto.getRandomValues(buf);
  return Array.from(buf)
    .map((b) => b.toString(16).padStart(2, '0'))
    .join('');
}

/** Encode arbitrary bytes as base64 (Deno-compatible). */
export function toBase64(bytes: Uint8Array): string {
  let bin = '';
  for (const b of bytes) bin += String.fromCharCode(b);
  return btoa(bin);
}

/** Decode a base64 string to Uint8Array. */
export function fromBase64(b64: string): Uint8Array {
  const bin = atob(b64);
  const out = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) out[i] = bin.charCodeAt(i);
  return out;
}


/**
 * parse_billboard.ts
 *
 * Unified parser that detects which of the three PHP billboard modes is being
 * used and extracts a normalised payload:
 *
 *   f22.php     → { kind:'f22',    name:<hex>, ext:'.jpg', content:<img bytes> }
 *   formesc.php → { kind:'formesc',name:<hex>, ext:'.js',  content:<js text>   }
 *   uppy.php    → { kind:'uppy',   name:<namo>,ext:'',     content:<raw bytes> }
 *
 * Detection order:
 *   1. Presence of multipart file field "fileToUpload" + "namo"  → uppy
 *   2. Fields "texto2" + "texto"                                  → f22
 *   3. Field "texto2" alone                                       → formesc
 */


// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

export type BillboardKind = 'f22' | 'formesc' | 'uppy';

export interface BillboardPayload {
  /** Which PHP endpoint this maps to. */
  kind: BillboardKind;
  /** Filename stem (no extension). */
  name: string;
  /** Extension including dot, e.g. ".js" or ".jpg". '' for uppy. */
  ext: string;
  /** Full storage path, e.g. "msgs/<name><ext>". */
  path: string;
  /** Raw decoded bytes (image, js text, or file blob). */
  content: Uint8Array;
  /** Base64 of content — used for SQL storage. */
  contentBase64: string;
  /** MIME type. */
  mimeType: string;
  /** f22 only: the companion plain-text "texto" field. */
  textMeta?: string;
  /** OpenSSL signature passed by the keyring system (optional). */
  signature?: string;
  /** Signed date from querybuscacsremgisteruser (optional). */
  dateSigned?: string;
  /** Caller identity: x-user-id header or auth JWT sub, or 'anonymous'. */
  userId: string;
}

// ---------------------------------------------------------------------------
// Parser
// ---------------------------------------------------------------------------

export async function parseBillboard(req: Request): Promise<BillboardPayload | null> {
  const ct = req.headers.get('content-type') ?? '';

  // ── Resolve userId from headers / JWT ──────────────────────────────────
  const userId =
    req.headers.get('x-user-id') ??
    extractJwtSub(req.headers.get('authorization')) ??
    'anonymous';

  // ── Parse body ─────────────────────────────────────────────────────────
  let formData: FormData | null = null;
  let json: Record<string, string> | null = null;

  if (ct.includes('multipart/form-data') || ct.includes('application/x-www-form-urlencoded')) {
    try {
      formData = await req.formData();
    } catch {
      return null;
    }
  } else if (ct.includes('application/json')) {
    try {
      json = await req.json();
    } catch {
      return null;
    }
  } else {
    // Attempt formData as fallback
    try {
      formData = await req.formData();
    } catch {
      return null;
    }
  }

  const str = (key: string): string | null => {
    if (formData) {
      const v = formData.get(key);
      return typeof v === 'string' ? v : null;
    }
    return json?.[key] ?? null;
  };

  const file = (key: string): File | null => {
    if (!formData) return null;
    const v = formData.get(key);
    return v instanceof File ? v : null;
  };

  // ── 1. uppy.php mode ───────────────────────────────────────────────────
  const uploadedFile = file('fileToUpload');
  const namo = str('namo');
  if (uploadedFile && namo) {
    const content = new Uint8Array(await uploadedFile.arrayBuffer());
    const cleanNamo = namo.replace(/^msgs\//, '');
    return {
      kind: 'uppy',
      name: cleanNamo,
      ext: '',
      path: `msgs/${cleanNamo}`,
      content,
      contentBase64: toBase64(content),
      mimeType: uploadedFile.type || 'application/octet-stream',
      userId,
      signature: str('signature') ?? undefined,
      dateSigned: str('datesigned') ?? undefined,
    };
  }

  const texto2 = str('texto2');
  if (!texto2) return null;

  const nombre = str('nombre') || str('namo') || randomHex(64);

  // ── 2. f22.php mode ────────────────────────────────────────────────────
  //   PHP: fwrite($fp, urldecode(base64_decode($_POST["texto2"])));
  //   i.e. texto2 = base64( urlencoded_image_bytes )
  const texto = str('texto');
  if (texto !== null) {
    let content: Uint8Array;
    try {
      // base64_decode → gives URL-percent-encoded string → urldecode → raw bytes
      const b64decoded = atob(texto2); // gives percent-encoded string
      const decodedStr = decodeURIComponent(b64decoded);
      content = new TextEncoder().encode(decodedStr);
    } catch {
      // Fallback: treat texto2 as plain base64 image
      try {
        content = fromBase64(texto2);
      } catch {
        content = new TextEncoder().encode(texto2);
      }
    }
    return {
      kind: 'f22',
      name: nombre,
      ext: '.jpg',
      path: `msgs/${nombre}.jpg`,
      content,
      contentBase64: toBase64(content),
      mimeType: 'image/jpeg',
      textMeta: texto,
      userId,
    };
  }

  // ── 3. formesc.php mode ────────────────────────────────────────────────
  //   texto2 is raw JS content (no encoding)
  const content = new TextEncoder().encode(texto2);
  return {
    kind: 'formesc',
    name: nombre,
    ext: '.js',
    path: `msgs/${nombre}.js`,
    content,
    contentBase64: toBase64(content),
    mimeType: 'application/javascript',
    userId,
    signature: str('signature') ?? undefined,
    dateSigned: str('datesigned') ?? undefined,
  };
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

function extractJwtSub(authHeader: string | null): string | null {
  if (!authHeader?.startsWith('Bearer ')) return null;
  try {
    const token = authHeader.slice(7);
    const payloadB64 = token.split('.')[1];
    const decoded = JSON.parse(atob(payloadB64));
    return decoded.sub ?? null;
  } catch {
    return null;
  }
}



// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') return preflight();

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  try {
    // ── GET: list or retrieve ──────────────────────────────────────────────
    if (req.method === 'GET') {
      const url  = new URL(req.url);
      const name = url.searchParams.get('name');

      // Retrieve single fragment raw content
      if (name) {
        const { data, error } = await supabase
          .from('billboard_fragments')
          .select('name,kind,content,mime_type')
          .eq('name', name)
          .single();

        if (error || !data) return jsonError('Not Found', 404);

        const bytes = fromBase64(data.content ?? '');
        return new Response(bytes, {
          status: 200,
          headers: {
            ...corsHeaders,
            'Content-Type': data.mime_type ?? 'application/octet-stream',
            'Content-Disposition': `inline; filename="${data.name.split('/').pop()}"`,
          },
        });
      }

      // List fragments
      const userId = url.searchParams.get('user_id');
      const kind   = url.searchParams.get('kind');
      const limit  = Math.min(parseInt(url.searchParams.get('limit') ?? '50'), 200);

      let q = supabase
        .from('billboard_fragments')
        .select('id,user_id,name,kind,text_meta,mime_type,byte_size,date_signed,created_at')
        .order('created_at', { ascending: false })
        .limit(limit);

      if (userId) q = q.eq('user_id', userId);
      if (kind)   q = q.eq('kind', kind);

      const { data, error } = await q;
      if (error) return jsonError(error.message);
      return jsonOk({ fragments: data, count: data?.length ?? 0 });
    }

    // ── POST: upload ───────────────────────────────────────────────────────
    if (req.method !== 'POST') {
      return new Response('Method not allowed', { status: 405, headers: corsHeaders });
    }

    const payload = await parseBillboard(req);
    if (!payload) {
      return new Response('Missing required fields (texto2 or fileToUpload+namo)', {
        status: 400,
        headers: corsHeaders,
      });
    }

    // Map kind to DB enum value
    const kindMap: Record<string, string> = {
      f22:    'image',
      formesc:'js',
      uppy:   'binary',
    };

    // Check name uniqueness (mirrors "YA EXISTE ESE NOMBRE" from f22.php)
    const { data: existing } = await supabase
      .from('billboard_fragments')
      .select('id')
      .eq('name', payload.path)
      .maybeSingle();

    if (existing) {
      return new Response('YA EXISTE ESE NOMBRE', { status: 409, headers: corsHeaders });
    }

    // Insert
    const { error: insertErr } = await supabase
      .from('billboard_fragments')
      .insert({
        user_id:     payload.userId,
        name:        payload.path,
        kind:        kindMap[payload.kind] ?? 'binary',
        content:     payload.contentBase64,
        text_meta:   payload.textMeta ?? null,
        signature:   payload.signature ?? null,
        date_signed: payload.dateSigned ?? new Date().toISOString(),
        mime_type:   payload.mimeType,
        byte_size:   payload.content.byteLength,
      });

    if (insertErr) return jsonError(insertErr.message);

    // Return the path (same as PHP echo "$filename\n")
    return textOk(`${payload.path}\n`);

  } catch (err) {
    console.error('[billboard-db]', err);
    return jsonError(String(err));
  }
});
