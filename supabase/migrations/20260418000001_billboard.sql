-- =============================================================================
-- Billboard Fragments — Migration 001
-- Supports all three storage strategies from the PHP billboard (f22, formesc, uppy)
-- =============================================================================

-- ---------------------------------------------------------------------------
-- 1. SQL-DB strategy table
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.billboard_fragments (
  id           UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      TEXT         NOT NULL DEFAULT 'anonymous',
  name         TEXT         UNIQUE NOT NULL,          -- e.g. msgs/<hex>.js
  kind         TEXT         NOT NULL
                              CHECK (kind IN ('image','js','text','binary')),
  content      TEXT,                                  -- base64 encoded payload
  text_meta    TEXT,                                  -- f22 "texto" plain-text companion
  signature    TEXT,                                  -- optional OpenSSL signature (base64)
  date_signed  TIMESTAMPTZ,
  mime_type    TEXT,
  byte_size    BIGINT,
  created_at   TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_billboard_user    ON public.billboard_fragments (user_id);
CREATE INDEX IF NOT EXISTS idx_billboard_kind    ON public.billboard_fragments (kind);
CREATE INDEX IF NOT EXISTS idx_billboard_created ON public.billboard_fragments (created_at DESC);

-- RLS: open-billboard — anyone can post, anyone can read (mirrors open PHP endpoints)
ALTER TABLE public.billboard_fragments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "billboard_insert" ON public.billboard_fragments;
CREATE POLICY "billboard_insert" ON public.billboard_fragments
  FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "billboard_select" ON public.billboard_fragments;
CREATE POLICY "billboard_select" ON public.billboard_fragments
  FOR SELECT USING (true);

-- ---------------------------------------------------------------------------
-- 2. Aggregated-per-user metadata table (storage-aggregated strategy)
--    Keeps a lightweight index of what is in the aggregated storage file
--    so we can answer listing queries without downloading the whole blob.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.billboard_user_index (
  user_id      TEXT         PRIMARY KEY,
  entry_count  INTEGER      NOT NULL DEFAULT 0,
  last_updated TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  storage_path TEXT         NOT NULL   -- bucket path to aggregated JSON file
);

ALTER TABLE public.billboard_user_index ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "user_index_all"  ON public.billboard_user_index;
CREATE POLICY "user_index_all" ON public.billboard_user_index
  USING (true) WITH CHECK (true);

-- ---------------------------------------------------------------------------
-- 3. Storage buckets (created here so migrations are idempotent)
-- ---------------------------------------------------------------------------
INSERT INTO storage.buckets (id, name, public)
  VALUES
    ('billboard-files',      'billboard-files',      true),
    ('billboard-aggregated', 'billboard-aggregated', false)
  ON CONFLICT (id) DO NOTHING;

-- Storage policies — billboard-files: public read, open write
DROP POLICY IF EXISTS "files_insert" ON storage.objects;
CREATE POLICY "files_insert" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'billboard-files');

DROP POLICY IF EXISTS "files_select" ON storage.objects;
CREATE POLICY "files_select" ON storage.objects
  FOR SELECT USING (bucket_id = 'billboard-files');

-- billboard-aggregated: open write (service role reads via edge function)
DROP POLICY IF EXISTS "agg_insert" ON storage.objects;
CREATE POLICY "agg_insert" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'billboard-aggregated');

DROP POLICY IF EXISTS "agg_update" ON storage.objects;
CREATE POLICY "agg_update" ON storage.objects
  FOR UPDATE USING (bucket_id = 'billboard-aggregated');

DROP POLICY IF EXISTS "agg_select" ON storage.objects;
CREATE POLICY "agg_select" ON storage.objects
  FOR SELECT USING (bucket_id = 'billboard-aggregated');
