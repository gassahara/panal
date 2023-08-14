/*
 * Copyright (c) 2007-2014, Cameron Rich
 * 
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, 
 *   this list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, 
 *   this list of conditions and the following disclaimer in the documentation 
 *   and/or other materials provided with the distribution.
 * * Neither the name of the axTLS project nor the names of its contributors 
 *   may be used to endorse or promote products derived from this software 
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * Implements the RSA public encryption algorithm. Uses the bigint library to
 * perform its calculations.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdlib.h>
#include <limits.h>


/*
#include "os_port.h"
#include "crypto.h"
*/

#define V1      v->comps[v->size-1]                 /**< v1 for division */
#define V2      v->comps[v->size-2]                 /**< v2 for division */
#define U(j)    tmp_u->comps[tmp_u->size-j-1]       /**< uj for division */
#define Q(j)    quotient->comps[quotient->size-j-1] /**< qj for division */
#define COMP_RADIX          4294967296ULL         /**< Max component + 1 */
#define COMP_MAX            0xFFFFFFFFFFFFFFFFULL /**< (Max dbl comp -1) */
#define BIGINT_M_OFFSET     0    /*< Normal modulo offset. */
#define COMP_BIT_SIZE       32  /*< Number of bits in a component.  */
#define COMP_BYTE_SIZE      4   /*< Number of bytes in a component. */
#define COMP_NUM_NIBBLES    8   /*< Used For diagnostics only. */
#define BIGINT_P_OFFSET     1    /**< p modulo offset. */
#define BIGINT_Q_OFFSET     2    /**< q module offset. */
#define BIGINT_NUM_MODS     3    /**< The number of modulus constants used. */
#define PERMANENT           0x7FFF55AA  /**< A magic number for permanents. */
typedef uint32_t comp;	        /**< A single precision component. */
typedef uint64_t long_comp;     /**< A double precision component. */
typedef int64_t slong_comp;     /**< A signed double precision component. */

#define max(a,b) ((a)>(b)?(a):(b))  /**< Find the maximum of 2 numbers. */
#define min(a,b) ((a)<(b)?(a):(b))  /**< Find the minimum of 2 numbers. */

/**
 * @struct  _bigint
 * @brief A big integer basic object
 */
struct _bigint
{
    struct _bigint* next;       /**< The next bigint in the cache. */
    short size;                 /**< The number of components in this bigint. */
    short max_comps;            /**< The heapsize allocated for this bigint */
    int refs;                   /**< An internal reference count. */
    comp* comps;                /**< A ptr to the actual component data */
};

typedef struct _bigint bigint;  /**< An alias for _bigint */

/**
 * Maintains the state of the cache, and a number of variables used in 
 * reduction.
 */
typedef struct /**< A big integer "session" context. */
{
    bigint *active_list;                    /**< Bigints currently used. */
    bigint *free_list;                      /**< Bigints not used. */
    bigint *bi_radix;                       /**< The radix used. */
    bigint *bi_mod[BIGINT_NUM_MODS];        /**< modulus */

    bigint *bi_normalised_mod[BIGINT_NUM_MODS]; /**< Normalised mod storage. */
    bigint **g;                 /**< Used by sliding-window. */
    int window;                 /**< The size of the sliding window */
    int active_count;           /**< Number of active bigints. */
    int free_count;             /**< Number of free bigints. */

    uint8_t mod_offset;         /**< The mod offset we are using */
    bigint *bi_RR_mod_m[BIGINT_NUM_MODS];   /**< R^2 mod m */
    bigint *bi_R_mod_m[BIGINT_NUM_MODS];    /**< R mod m */
    comp N0_dash[BIGINT_NUM_MODS];
} BI_CTX;



typedef struct 
{
    bigint *m;              /* modulus */
    bigint *e;              /* public exponent */
    bigint *d;              /* private exponent */
    bigint *p;              /* p as in m = pq */
    bigint *q;              /* q as in m = pq */
    bigint *dP;             /* d mod (p-1) */
    bigint *dQ;             /* d mod (q-1) */
    bigint *qInv;           /* q^-1 mod p */
    int num_octets;
    BI_CTX *bi_ctx;
} RSA_CTX;




/*
void RSA_priv_key_new(RSA_CTX **ctx, 
        const uint8_t *modulus, int mod_len,
        const uint8_t *pub_exp, int pub_len,
        const uint8_t *priv_exp, int priv_len
#if CONFIG_BIGINT_CRT
      , const uint8_t *p, int p_len,
        const uint8_t *q, int q_len,
        const uint8_t *dP, int dP_len,
        const uint8_t *dQ, int dQ_len,
        const uint8_t *qInv, int qInv_len
#endif
    )
{
    RSA_CTX *rsa_ctx;
    BI_CTX *bi_ctx;
    RSA_pub_key_new(ctx, modulus, mod_len, pub_exp, pub_len);
    rsa_ctx = *ctx;
    bi_ctx = rsa_ctx->bi_ctx;
    rsa_ctx->d = bi_import(bi_ctx, priv_exp, priv_len);
    bi_permanent(rsa_ctx->d);

#ifdef CONFIG_BIGINT_CRT
    rsa_ctx->p = bi_import(bi_ctx, p, p_len);
    rsa_ctx->q = bi_import(bi_ctx, q, q_len);
    rsa_ctx->dP = bi_import(bi_ctx, dP, dP_len);
    rsa_ctx->dQ = bi_import(bi_ctx, dQ, dQ_len);
    rsa_ctx->qInv = bi_import(bi_ctx, qInv, qInv_len);
    bi_permanent(rsa_ctx->dP);
    bi_permanent(rsa_ctx->dQ);
    bi_permanent(rsa_ctx->qInv);
    bi_set_mod(bi_ctx, rsa_ctx->p, BIGINT_P_OFFSET);
    bi_set_mod(bi_ctx, rsa_ctx->q, BIGINT_Q_OFFSET);
#endif
}
*/






static void more_comps(bigint *bi, int n)
{
    if (n > bi->max_comps)
    {
        bi->max_comps = max(bi->max_comps * 2, n);
        bi->comps = (comp*)realloc(bi->comps, bi->max_comps * COMP_BYTE_SIZE);
    }

    if (n > bi->size)
    {
        memset(&bi->comps[bi->size], 0, (n-bi->size)*COMP_BYTE_SIZE);
    }

    bi->size = n;
}

/*
 * Make a new empty bigint. It may just use an old one if one is available.
 * Otherwise get one off the heap.
 */
static bigint *alloc(BI_CTX *ctx, int size)
{
    bigint *biR;

    /* Can we recycle an old bigint? */
    if (ctx->free_list != NULL)
    {
        biR = ctx->free_list;
        ctx->free_list = biR->next;
        ctx->free_count--;

        if (biR->refs != 0)
        {
#ifdef CONFIG_SSL_FULL_MODE
            printf("alloc: refs was not 0\n");
#endif
            abort();    /* create a stack trace from a core dump */
        }

        more_comps(biR, size);
    }
    else
    {
        /* No free bigints available - create a new one. */
        biR = (bigint *)malloc(sizeof(bigint));
        biR->comps = (comp*)malloc(size * COMP_BYTE_SIZE);
        biR->max_comps = size;  /* give some space to spare */
    }

    biR->size = size;
    biR->refs = 1;
    biR->next = NULL;
    ctx->active_count++;
    return biR;
}


/**
 * @brief Simply make a bigint object "unfreeable" if bi_free() is called on it.
 *
 * For this object to be freed, bi_depermanent() must be called.
 * @param bi [in]   The bigint to be made permanent.
 */
void bi_permanent(bigint *bi)
{
//    check(bi);
    if (bi->refs != 1)
    {
#ifdef CONFIG_SSL_FULL_MODE
        printf("bi_permanent: refs was not 1\n");
#endif
        abort();
    }

    bi->refs = PERMANENT;
}

/**
 * @brief Take a permanent object and make it eligible for freedom.
 * @param bi [in]   The bigint to be made back to temporary.
 */
void bi_depermanent(bigint *bi)
{
//    check(bi);
    if (bi->refs != PERMANENT)
    {
#ifdef CONFIG_SSL_FULL_MODE
        printf("bi_depermanent: bigint was not permanent\n");
#endif
        abort();
    }

    bi->refs = 1;
}

/**
 * @brief Free a bigint object so it can be used again. 
 *
 * The memory itself it not actually freed, just tagged as being available 
 * @param ctx [in]   The bigint session context.
 * @param bi [in]    The bigint to be freed.
 */
void bi_free(BI_CTX *ctx, bigint *bi)
{
//    check(bi);
    if (bi->refs == PERMANENT)
    {
        return;
    }

    if (--bi->refs > 0)
    {
        return;
    }

    bi->next = ctx->free_list;
    ctx->free_list = bi;
    ctx->free_count++;

    if (--ctx->active_count < 0)
    {
#ifdef CONFIG_SSL_FULL_MODE
        printf("bi_free: active_count went negative "
                "- double-freed bigint?\n");
#endif
        abort();
    }
}

BI_CTX *bi_initialize(void)
{
    /* calloc() sets everything to zero */
    BI_CTX *ctx = (BI_CTX *)calloc(1, sizeof(BI_CTX));
   
    /* the radix */
    //    ctx->bi_radix = alloc(ctx, 2); 
    ctx->bi_radix->comps[0] = 0;
    ctx->bi_radix->comps[1] = 1;
    bi_permanent(ctx->bi_radix);
    return ctx;
}


/**
 *@brief Clear the memory cache.
 */
void bi_clear_cache(BI_CTX *ctx)
{
    bigint *p, *pn;

    if (ctx->free_list == NULL)
        return;
    
    for (p = ctx->free_list; p != NULL; p = pn)
    {
        pn = p->next;
        free(p->comps);
        free(p);
    }

    ctx->free_count = 0;
    ctx->free_list = NULL;
}


/**
 * @brief Close the bigint context and free any resources.
 *
 * Free up any used memory - a check is done if all objects were not 
 * properly freed.
 * @param ctx [in]   The bigint session context.
 */
void bi_terminate(BI_CTX *ctx)
{
    bi_depermanent(ctx->bi_radix); 
    bi_free(ctx, ctx->bi_radix);

    if (ctx->active_count != 0)
    {
#ifdef CONFIG_SSL_FULL_MODE
        printf("bi_terminate: there were %d un-freed bigints\n",
                       ctx->active_count);
#endif
        abort();
    }

    bi_clear_cache(ctx);
    free(ctx);
}



/**
 * @brief Increment the number of references to this object. 
 * It does not do a full copy.
 * @param bi [in]   The bigint to copy.
 * @return A reference to the same bigint.
 */
bigint *bi_copy(bigint *bi)
{
//    check(bi);
    if (bi->refs != PERMANENT)
        bi->refs++;
    return bi;
}
/**
 * @brief Convert an (unsigned) integer into a bigint.
 * @param ctx [in]   The bigint session context.
 * @param i [in]     The (unsigned) integer to be converted.
 * 
 */
bigint *int_to_bi(BI_CTX *ctx, comp i)
{
    bigint *biR = alloc(ctx, 1);
    biR->comps[0] = i;
    return biR;
}

/**
 * @brief Do a full copy of the bigint object.
 * @param ctx [in]   The bigint session context.
 * @param bi  [in]   The bigint object to be copied.
 */
bigint *bi_clone(BI_CTX *ctx, const bigint *bi)
{
    bigint *biR = alloc(ctx, bi->size);
//    check(bi);
    memcpy(biR->comps, bi->comps, bi->size*COMP_BYTE_SIZE);
    return biR;
}



static bigint *trim(bigint *bi)
{
    while (bi->comps[bi->size-1] == 0 && bi->size > 1)
    {
        bi->size--;
    }

    return bi;
}

/**
 * @brief Perform an addition operation between two bigints.
 * @param ctx [in]  The bigint session context.
 * @param bia [in]  A bigint.
 * @param bib [in]  Another bigint.
 * @return The result of the addition.
 */

bigint *bi_add(BI_CTX *ctx, bigint *bia, bigint *bib)
{
    int n;
    comp carry = 0;
    comp *pa, *pb;

//    check(bia);
//    check(bib);

    n = max(bia->size, bib->size);
    more_comps(bia, n+1);
    more_comps(bib, n);
    pa = bia->comps;
    pb = bib->comps;

    do
    {
        comp  sl, rl, cy1;
        sl = *pa + *pb++;
        rl = sl + carry;
        cy1 = sl < *pa;
        carry = cy1 | (rl < sl);
        *pa++ = rl;
    } while (--n != 0);

    *pa = carry;                  /* do overflow */
    bi_free(ctx, bib);
    return trim(bia);
}

/**
 * @brief Perform a subtraction operation between two bigints.
 * @param ctx [in]  The bigint session context.
 * @param bia [in]  A bigint.
 * @param bib [in]  Another bigint.
 * @param is_negative [out] If defined, indicates that the result was negative.
 * is_negative may be null.
 * @return The result of the subtraction. The result is always positive.
 */
bigint *bi_subtract(BI_CTX *ctx, 
        bigint *bia, bigint *bib, int *is_negative)
{
    int n = bia->size;
    comp *pa, *pb, carry = 0;

//    check(bia);
//    check(bib);

    more_comps(bib, n);
    pa = bia->comps;
    pb = bib->comps;

    do 
    {
        comp sl, rl, cy1;
        sl = *pa - *pb++;
        rl = sl - carry;
        cy1 = sl > *pa;
        carry = cy1 | (rl > sl);
        *pa++ = rl;
    } while (--n != 0);

    if (is_negative)    /* indicate a negative result */
    {
        *is_negative = carry;
    }

    bi_free(ctx, trim(bib));    /* put bib back to the way it was */
    return trim(bia);
}

/**
 * Perform a multiply between a bigint an an (unsigned) integer
 */
static bigint *bi_int_multiply(BI_CTX *ctx, bigint *bia, comp b)
{
    int j = 0, n = bia->size;
    bigint *biR = alloc(ctx, n + 1);
    comp carry = 0;
    comp *r = biR->comps;
    comp *a = bia->comps;

//    check(bia);

    /* clear things to start with */
    memset(r, 0, ((n+1)*COMP_BYTE_SIZE));

    do
    {
        long_comp tmp = *r + (long_comp)a[j]*b + carry;
        *r++ = (comp)tmp;              /* downsize */
        carry = (comp)(tmp >> COMP_BIT_SIZE);
    } while (++j < n);

    *r = carry;
    bi_free(ctx, bia);
    return trim(biR);
}


/**
 * @brief Compare two bigints.
 * @param bia [in]  A bigint.
 * @param bib [in]  Another bigint.
 * @return -1 if smaller, 1 if larger and 0 if equal.
 */
int bi_compare(bigint *bia, bigint *bib)
{
    int r, i;

//    check(bia);
//    check(bib);

    if (bia->size > bib->size)
        r = 1;
    else if (bia->size < bib->size)
        r = -1;
    else
    {
        comp *a = bia->comps; 
        comp *b = bib->comps; 

        /* Same number of components.  Compare starting from the high end
         * and working down. */
        r = 0;
        i = bia->size - 1;

        do 
        {
            if (a[i] > b[i])
            { 
                r = 1;
                break; 
            }
            else if (a[i] < b[i])
            { 
                r = -1;
                break; 
            }
        } while (--i >= 0);
    }

    return r;
}




/*
 * Perform an integer divide on a bigint.
 */
static bigint *bi_int_divide(BI_CTX *ctx, bigint *biR, comp denom)
{
    int i = biR->size - 1;
    long_comp r = 0;

//    check(biR);

    do
    {
        r = (r<<COMP_BIT_SIZE) + biR->comps[i];
        biR->comps[i] = (comp)(r / denom);
        r %= denom;
    } while (--i >= 0);

    return trim(biR);
}

/**
 * There is a need for the value of integer N' such that B^-1(B-1)-N^-1N'=1, 
 * where B^-1(B-1) mod N=1. Actually, only the least significant part of 
 * N' is needed, hence the definition N0'=N' mod b. We reproduce below the 
 * simple algorithm from an article by Dusse and Kaliski to efficiently 
 * find N0' from N0 and b */
static comp modular_inverse(bigint *bim)
{
    int i;
    comp t = 1;
    comp two_2_i_minus_1 = 2;   /* 2^(i-1) */
    long_comp two_2_i = 4;      /* 2^i */
    comp N = bim->comps[0];

    for (i = 2; i <= COMP_BIT_SIZE; i++)
    {
        if ((long_comp)N*t%two_2_i >= two_2_i_minus_1)
        {
            t += two_2_i_minus_1;
        }

        two_2_i_minus_1 <<= 1;
        two_2_i <<= 1;
    }

    return (comp)(COMP_RADIX-t);
}

/**
 * Take each component and shift down (in terms of components) 
 */
static bigint *comp_right_shift(bigint *biR, int num_shifts)
{
    int i = biR->size-num_shifts;
    comp *x = biR->comps;
    comp *y = &biR->comps[num_shifts];

//    check(biR);

    if (i <= 0)     /* have we completely right shifted? */
    {
        biR->comps[0] = 0;  /* return 0 */
        biR->size = 1;
        return biR;
    }

    do
    {
        *x++ = *y++;
    } while (--i > 0);

    biR->size -= num_shifts;
    return biR;
}

/**
 * Take each component and shift it up (in terms of components) 
 */
static bigint *comp_left_shift(bigint *biR, int num_shifts)
{
    int i = biR->size-1;
    comp *x, *y;

//    check(biR);

    if (num_shifts <= 0)
    {
        return biR;
    }

    more_comps(biR, biR->size + num_shifts);

    x = &biR->comps[i+num_shifts];
    y = &biR->comps[i];

    do
    {
        *x-- = *y--;
    } while (i--);

    memset(biR->comps, 0, num_shifts*COMP_BYTE_SIZE); /* zero LS comps */
    return biR;
}



/**
 * @brief Does both division and modulo calculations. 
 *
 * Used extensively when doing classical reduction.
 * @param ctx [in]  The bigint session context.
 * @param u [in]    A bigint which is the numerator.
 * @param v [in]    Either the denominator or the modulus depending on the mode.
 * @param is_mod [n] Determines if this is a normal division (0) or a reduction
 * (1).
 * @return  The result of the division/reduction.
 */ 
bigint *bi_divide(BI_CTX *ctx, bigint *u, bigint *v, int is_mod) {
    int n = v->size, m = u->size-n;
    int j = 0, orig_u_size = u->size;
    uint8_t mod_offset = ctx->mod_offset;
    comp d;
    bigint *quotient, *tmp_u;
    comp q_dash;

//    check(u);
//    check(v);

    // if doing reduction and we are < mod, then return mod 
    if (is_mod && bi_compare(v, u) > 0) {
        bi_free(ctx, v);
        return u;
    }

    quotient = alloc(ctx, m+1);
    tmp_u = alloc(ctx, n+1);
    v = trim(v);        // make sure we have no leading 0's 
    d = (comp)((long_comp)COMP_RADIX/(V1+1));

    // clear things to start with 
    memset(quotient->comps, 0, ((quotient->size)*COMP_BYTE_SIZE));

    // normalise 
    if (d > 1)  {
        u = bi_int_multiply(ctx, u, d);
        if (is_mod) {
            v = ctx->bi_normalised_mod[mod_offset];
        } else {
            v = bi_int_multiply(ctx, v, d);
        }
    }

    if (orig_u_size == u->size){  // new digit position u0
        more_comps(u, orig_u_size + 1);
    }

    do {
        // get a temporary short version of u 
        memcpy(tmp_u->comps, &u->comps[u->size-n-1-j], (n+1)*COMP_BYTE_SIZE);
        // calculate q' 
        if (U(0) == V1) {
            q_dash = COMP_RADIX-1;
        } else {
            q_dash = (comp)(((long_comp)U(0)*COMP_RADIX + U(1))/V1);
            if (v->size > 1 && V2){
                comp inner = (comp)((long_comp)COMP_RADIX*U(0) + U(1) - (long_comp)q_dash*V1);
                if ((long_comp)V2*q_dash > (long_comp)inner*COMP_RADIX + U(2)) q_dash--;
            }
        }

        // multiply and subtract 
        if (q_dash) {
            int is_negative;
            tmp_u = bi_subtract(ctx, tmp_u, bi_int_multiply(ctx, bi_copy(v), q_dash), &is_negative);
            more_comps(tmp_u, n+1);
            Q(j) = q_dash; 
            // add back 
            if (is_negative) {
                Q(j)--;
                tmp_u = bi_add(ctx, tmp_u, bi_copy(v));
                // lop off the carry 
                tmp_u->size--;
                v->size--;
            }
        } else {
            Q(j) = 0; 
        }
        // copy back to u 
        memcpy(&u->comps[u->size-n-1-j], tmp_u->comps, (n+1)*COMP_BYTE_SIZE);
    } while (++j <= m);

    bi_free(ctx, tmp_u);
    bi_free(ctx, v);

    if (is_mod)     // get the remainder 
    {
        bi_free(ctx, quotient);
        return bi_int_divide(ctx, trim(u), d);
    }
    else            // get the quotient 
    {
        bi_free(ctx, u);
        return trim(quotient);
    }
}

#define bi_mod(A, B)      bi_divide(A, B, ctx->bi_mod[ctx->mod_offset], 1)

/**
 * @brief Allow a binary sequence to be imported as a bigint.
 * @param ctx [in]  The bigint session context.
 * @param data [in] The data to be converted.
 * @param size [in] The number of bytes of data.
 * @return A bigint representing this data.
 */
bigint *bi_import(BI_CTX *ctx, const uint8_t *data, int size)
{
    bigint *biR = alloc(ctx, (size+COMP_BYTE_SIZE-1)/COMP_BYTE_SIZE);
    int i, j = 0, offset = 0;

    memset(biR->comps, 0, biR->size*COMP_BYTE_SIZE);

    for (i = size-1; i >= 0; i--)
    {
        biR->comps[offset] += data[i] << (j*8);

        if (++j == COMP_BYTE_SIZE)
        {
            j = 0;
            offset ++;
        }
    }

    return trim(biR);
}

#ifdef CONFIG_SSL_FULL_MODE
/**
 * @brief The testharness uses this code to import text hex-streams and 
 * convert them into bigints.
 * @param ctx [in]  The bigint session context.
 * @param data [in] A string consisting of hex characters. The characters must
 * be in upper case.
 * @return A bigint representing this data.
 */
bigint *bi_str_import(BI_CTX *ctx, const char *data)
{
    int size = strlen(data);
    bigint *biR = alloc(ctx, (size+COMP_NUM_NIBBLES-1)/COMP_NUM_NIBBLES);
    int i, j = 0, offset = 0;
    memset(biR->comps, 0, biR->size*COMP_BYTE_SIZE);

    for (i = size-1; i >= 0; i--)
    {
        int num = (data[i] <= '9') ? (data[i] - '0') : (data[i] - 'A' + 10);
        biR->comps[offset] += num << (j*4);

        if (++j == COMP_NUM_NIBBLES)
        {
            j = 0;
            offset ++;
        }
    }

    return biR;
}

void bi_print(const char *label, bigint *x)
{
    int i, j;

    if (x == NULL)
    {
        printf("%s: (null)\n", label);
        return;
    }

    printf("%s: (size %d)\n", label, x->size);
    for (i = x->size-1; i >= 0; i--)
    {
        for (j = COMP_NUM_NIBBLES-1; j >= 0; j--)
        {
            comp mask = 0x0f << (j*4);
            comp num = (x->comps[i] & mask) >> (j*4);
            putc((num <= 9) ? (num + '0') : (num + 'A' - 10), stdout);
        }
    }  

    printf("\n");
}
#endif

/**
 * @brief Take a bigint and convert it into a byte sequence. 
 *
 * This is useful after a decrypt operation.
 * @param ctx [in]  The bigint session context.
 * @param x [in]  The bigint to be converted.
 * @param data [out] The converted data as a byte stream.
 * @param size [in] The maximum size of the byte stream. Unused bytes will be
 * zeroed.
 */
void bi_export(BI_CTX *ctx, bigint *x, uint8_t *data, int size)
{
    int i, j, k = size-1;

//    check(x);
    memset(data, 0, size);  /* ensure all leading 0's are cleared */

    for (i = 0; i < x->size; i++)
    {
        for (j = 0; j < COMP_BYTE_SIZE; j++)
        {
            comp mask = 0xff << (j*8);
            int num = (x->comps[i] & mask) >> (j*8);
            data[k--] = num;

            if (k < 0)
            {
                goto buf_done;
            }
        }
    }
buf_done:

    bi_free(ctx, x);
}

/**
 * @brief Pre-calculate some of the expensive steps in reduction. 
 *
 * This function should only be called once (normally when a session starts).
 * When the session is over, bi_free_mod() should be called. bi_mod_power()
 * relies on this function being called.
 * @param ctx [in]  The bigint session context.
 * @param bim [in]  The bigint modulus that will be used.
 * @param mod_offset [in] There are three moduluii that can be stored - the
 * standard modulus, and its two primes p and q. This offset refers to which
 * modulus we are referring to.
 * @see bi_free_mod(), bi_mod_power().
 */
void bi_set_mod(BI_CTX *ctx, bigint *bim, int mod_offset)
{
    int k = bim->size;
    comp d = (comp)((long_comp)COMP_RADIX/(bim->comps[k-1]+1));
    bigint *R, *R2;

    ctx->bi_mod[mod_offset] = bim;
    bi_permanent(ctx->bi_mod[mod_offset]);
    ctx->bi_normalised_mod[mod_offset] = bi_int_multiply(ctx, bim, d);
    bi_permanent(ctx->bi_normalised_mod[mod_offset]);

    /* set montgomery variables */
    R = comp_left_shift(bi_clone(ctx, ctx->bi_radix), k-1);     /* R */
    R2 = comp_left_shift(bi_clone(ctx, ctx->bi_radix), k*2-1);  /* R^2 */
    ctx->bi_RR_mod_m[mod_offset] = bi_mod(ctx, R2);             /* R^2 mod m */
    ctx->bi_R_mod_m[mod_offset] = bi_mod(ctx, R);               /* R mod m */

    bi_permanent(ctx->bi_RR_mod_m[mod_offset]);
    bi_permanent(ctx->bi_R_mod_m[mod_offset]);

    ctx->N0_dash[mod_offset] = modular_inverse(ctx->bi_mod[mod_offset]);

}

/**
 * @brief Used when cleaning various bigints at the end of a session.
 * @param ctx [in]  The bigint session context.
 * @param mod_offset [in] The offset to use.
 * @see bi_set_mod().
 */
void bi_free_mod(BI_CTX *ctx, int mod_offset)
{
    bi_depermanent(ctx->bi_mod[mod_offset]);
    bi_free(ctx, ctx->bi_mod[mod_offset]);
#if defined (CONFIG_BIGINT_MONTGOMERY)
    bi_depermanent(ctx->bi_RR_mod_m[mod_offset]);
    bi_depermanent(ctx->bi_R_mod_m[mod_offset]);
    bi_free(ctx, ctx->bi_RR_mod_m[mod_offset]);
    bi_free(ctx, ctx->bi_R_mod_m[mod_offset]);
#elif defined(CONFIG_BIGINT_BARRETT)
    bi_depermanent(ctx->bi_mu[mod_offset]); 
    bi_free(ctx, ctx->bi_mu[mod_offset]);
#endif
    bi_depermanent(ctx->bi_normalised_mod[mod_offset]); 
    bi_free(ctx, ctx->bi_normalised_mod[mod_offset]);
}

/** 
 * Perform a standard multiplication between two bigints.
 *
 * Barrett reduction has no need for some parts of the product, so ignore bits
 * of the multiply. This routine gives Barrett its big performance
 * improvements over Classical/Montgomery reduction methods. 
 */
static bigint *regular_multiply(BI_CTX *ctx, bigint *bia, bigint *bib, 
        int inner_partial, int outer_partial)
{
    int i = 0, j;
    int n = bia->size;
    int t = bib->size;
    bigint *biR = alloc(ctx, n + t);
    comp *sr = biR->comps;
    comp *sa = bia->comps;
    comp *sb = bib->comps;

//    check(bia);
//    check(bib);

    /* clear things to start with */
    memset(biR->comps, 0, ((n+t)*COMP_BYTE_SIZE));

    do 
    {
        long_comp tmp;
        comp carry = 0;
        int r_index = i;
        j = 0;

        if (outer_partial && outer_partial-i > 0 && outer_partial < n)
        {
            r_index = outer_partial-1;
            j = outer_partial-i-1;
        }

        do
        {
            if (inner_partial && r_index >= inner_partial) 
            {
                break;
            }

            tmp = sr[r_index] + ((long_comp)sa[j])*sb[i] + carry;
            sr[r_index++] = (comp)tmp;              /* downsize */
            carry = tmp >> COMP_BIT_SIZE;
        } while (++j < n);

        sr[r_index] = carry;
    } while (++i < t);

    bi_free(ctx, bia);
    bi_free(ctx, bib);
    return trim(biR);
}


/*
 * Perform the actual square operion. It takes into account overflow.
 */
static bigint *regular_square(BI_CTX *ctx, bigint *bi)
{
    int t = bi->size;
    int i = 0, j;
    bigint *biR = alloc(ctx, t*2+1);
    comp *w = biR->comps;
    comp *x = bi->comps;
    long_comp carry;
    memset(w, 0, biR->size*COMP_BYTE_SIZE);

    do
    {
        long_comp tmp = w[2*i] + (long_comp)x[i]*x[i];
        w[2*i] = (comp)tmp;
        carry = tmp >> COMP_BIT_SIZE;

        for (j = i+1; j < t; j++)
        {
            uint8_t c = 0;
            long_comp xx = (long_comp)x[i]*x[j];
            if ((COMP_MAX-xx) < xx)
                c = 1;

            tmp = (xx<<1);

            if ((COMP_MAX-tmp) < w[i+j])
                c = 1;

            tmp += w[i+j];

            if ((COMP_MAX-tmp) < carry)
                c = 1;

            tmp += carry;
            w[i+j] = (comp)tmp;
            carry = tmp >> COMP_BIT_SIZE;

            if (c)
                carry += COMP_RADIX;
        }

        tmp = w[i+t] + carry;
        w[i+t] = (comp)tmp;
        w[i+t+1] = tmp >> COMP_BIT_SIZE;
    } while (++i < t);

    bi_free(ctx, bi);
    return trim(biR);
}



/**
 * @brief Perform a square operation on a bigint.
 * @param ctx [in]  The bigint session context.
 * @param bia [in]  A bigint.
 * @return The result of the multiplication.
 */
bigint *bi_square(BI_CTX *ctx, bigint *bia)
{
    return regular_square(ctx, bia);
}


#ifdef CONFIG_BIGINT_KARATSUBA
/*
 * Karatsuba improves on regular multiplication due to only 3 multiplications 
 * being done instead of 4. The additional additions/subtractions are O(N) 
 * rather than O(N^2) and so for big numbers it saves on a few operations 
 */
static bigint *karatsuba(BI_CTX *ctx, bigint *bia, bigint *bib, int is_square)
{
    bigint *x0, *x1;
    bigint *p0, *p1, *p2;
    int m;

    if (is_square)
    {
        m = (bia->size + 1)/2;
    }
    else
    {
        m = (max(bia->size, bib->size) + 1)/2;
    }

    x0 = bi_clone(ctx, bia);
    x0->size = m;
    x1 = bi_clone(ctx, bia);
    comp_right_shift(x1, m);
    bi_free(ctx, bia);

    /* work out the 3 partial products */
    if (is_square)
    {
        p0 = bi_square(ctx, bi_copy(x0));
        p2 = bi_square(ctx, bi_copy(x1));
        p1 = bi_square(ctx, bi_add(ctx, x0, x1));
    }
    else /* normal multiply */
    {
        bigint *y0, *y1;
        y0 = bi_clone(ctx, bib);
        y0->size = m;
        y1 = bi_clone(ctx, bib);
        comp_right_shift(y1, m);
        bi_free(ctx, bib);

        p0 = bi_multiply(ctx, bi_copy(x0), bi_copy(y0));
        p2 = bi_multiply(ctx, bi_copy(x1), bi_copy(y1));
        p1 = bi_multiply(ctx, bi_add(ctx, x0, x1), bi_add(ctx, y0, y1));
    }

    p1 = bi_subtract(ctx, 
            bi_subtract(ctx, p1, bi_copy(p2), NULL), bi_copy(p0), NULL);

    comp_left_shift(p1, m);
    comp_left_shift(p2, 2*m);
    return bi_add(ctx, p1, bi_add(ctx, p0, p2));
}
#endif

/**
 * @brief Perform a multiplication operation between two bigints.
 * @param ctx [in]  The bigint session context.
 * @param bia [in]  A bigint.
 * @param bib [in]  Another bigint.
 * @return The result of the multiplication.
 */
bigint *bi_multiply(BI_CTX *ctx, bigint *bia, bigint *bib)
{
//    check(bia);
//    check(bib);

#ifdef CONFIG_BIGINT_KARATSUBA
    if (min(bia->size, bib->size) < MUL_KARATSUBA_THRESH)
    {
        return regular_multiply(ctx, bia, bib, 0, 0);
    }

    return karatsuba(ctx, bia, bib, 0);
#else
    return regular_multiply(ctx, bia, bib, 0, 0);
#endif
}

/*
 * Work out the highest '1' bit in an exponent. Used when doing sliding-window
 * exponentiation.
 */
static int find_max_exp_index(bigint *biexp)
{
    int i = COMP_BIT_SIZE-1;
    comp shift = COMP_RADIX/2;
    comp test = biexp->comps[biexp->size-1];    /* assume no leading zeroes */

//    check(biexp);

    do
    {
        if (test & shift)
        {
            return i+(biexp->size-1)*COMP_BIT_SIZE;
        }

        shift >>= 1;
    } while (i-- != 0);

    return -1;      /* error - must have been a leading 0 */
}

/*
 * Is a particular bit is an exponent 1 or 0? Used when doing sliding-window
 * exponentiation.
 */
static int exp_bit_is_one(bigint *biexp, int offset)
{
    comp test = biexp->comps[offset / COMP_BIT_SIZE];
    int num_shifts = offset % COMP_BIT_SIZE;
    comp shift = 1;
    int i;

//    check(biexp);

    for (i = 0; i < num_shifts; i++)
    {
        shift <<= 1;
    }

    return (test & shift) != 0;
}

#ifdef CONFIG_BIGINT_CHECK_ON
/*
 * Perform a sanity check on bi.
 */
static void check(const bigint *bi)
{
    if (bi->refs <= 0)
    {
        printf("check: zero or negative refs in bigint\n");
        abort();
    }

    if (bi->next != NULL)
    {
        printf("check: attempt to use a bigint from "
                "the free list\n");
        abort();
    }
}
#endif

/*
 * Delete any leading 0's (and allow for 0).
 */
/**
 * @brief Perform a single montgomery reduction.
 * @param ctx [in]  The bigint session context.
 * @param bixy [in]  A bigint.
 * @return The result of the montgomery reduction.
 */
bigint *bi_mont(BI_CTX *ctx, bigint *bixy)
{
    int i = 0, n;
    uint8_t mod_offset = ctx->mod_offset;
    bigint *bim = ctx->bi_mod[mod_offset];
    comp mod_inv = ctx->N0_dash[mod_offset];

//    check(bixy);

    n = bim->size;

    do
    {
        bixy = bi_add(ctx, bixy, comp_left_shift(
                    bi_int_multiply(ctx, bim, bixy->comps[i]*mod_inv), i));
    } while (++i < n);

    comp_right_shift(bixy, n);

    if (bi_compare(bixy, bim) >= 0)
    {
        bixy = bi_subtract(ctx, bixy, bim, NULL);
    }

    return bixy;
}


#define bi_residue(A, B)         bi_mont(A, B)

#ifdef CONFIG_BIGINT_SLIDING_WINDOW
/*
 * Work out g1, g3, g5, g7... etc for the sliding-window algorithm 
 */
static void precompute_slide_window(BI_CTX *ctx, int window, bigint *g1)
{
    int k = 1, i;
    bigint *g2;

    for (i = 0; i < window-1; i++)   /* compute 2^(window-1) */
    {
        k <<= 1;
    }

    ctx->g = (bigint **)malloc(k*sizeof(bigint *));
    ctx->g[0] = bi_clone(ctx, g1);
    bi_permanent(ctx->g[0]);
    g2 = bi_residue(ctx, bi_square(ctx, ctx->g[0]));   /* g^2 */

    for (i = 1; i < k; i++)
    {
        ctx->g[i] = bi_residue(ctx, bi_multiply(ctx, ctx->g[i-1], bi_copy(g2)));
        bi_permanent(ctx->g[i]);
    }

    bi_free(ctx, g2);
    ctx->window = k;
}
#endif

/**
 * @brief Perform a modular exponentiation.
 *
 * This function requires bi_set_mod() to have been called previously. This is 
 * one of the optimisations used for performance.
 * @param ctx [in]  The bigint session context.
 * @param bi  [in]  The bigint on which to perform the mod power operation.
 * @param biexp [in] The bigint exponent.
 * @return The result of the mod exponentiation operation
 * @see bi_set_mod().
 */
bigint *bi_mod_power(BI_CTX *ctx, bigint *bi, bigint *biexp)
{
    int i = find_max_exp_index(biexp), j, window_size = 1;
    bigint *biR = int_to_bi(ctx, 1);

    uint8_t mod_offset = ctx->mod_offset;

//    check(bi);
//    check(biexp);

    ctx->g = (bigint **)malloc(sizeof(bigint *));
    ctx->g[0] = bi_clone(ctx, bi);
    ctx->window = 1;
    bi_permanent(ctx->g[0]);

    /* if sliding-window is off, then only one bit will be done at a time and
     * will reduce to standard left-to-right exponentiation */
    do
    {
        if (exp_bit_is_one(biexp, i))
        {
            int l = i-window_size+1;
            int part_exp = 0;

            if (l < 0)  /* LSB of exponent will always be 1 */
                l = 0;
            else
            {
                while (exp_bit_is_one(biexp, l) == 0)
                    l++;    /* go back up */
            }

            /* build up the section of the exponent */
            for (j = i; j >= l; j--)
            {
                biR = bi_residue(ctx, bi_square(ctx, biR));
                if (exp_bit_is_one(biexp, j))
                    part_exp++;

                if (j != l)
                    part_exp <<= 1;
            }

            part_exp = (part_exp-1)/2;  /* adjust for array */
            biR = bi_residue(ctx, bi_multiply(ctx, biR, ctx->g[part_exp]));
            i = l-1;
        }
        else    /* square it */
        {
            biR = bi_residue(ctx, bi_square(ctx, biR));
            i--;
        }
    } while (i >= 0);
     
    /* cleanup */
    for (i = 0; i < ctx->window; i++)
    {
        bi_depermanent(ctx->g[i]);
        bi_free(ctx, ctx->g[i]);
    }

    free(ctx->g);
    bi_free(ctx, bi);
    bi_free(ctx, biexp);
#if defined CONFIG_BIGINT_MONTGOMERY
    return ctx->use_classical ? biR : bi_mont(ctx, biR); /* convert back */
#else /* CONFIG_BIGINT_CLASSICAL or CONFIG_BIGINT_BARRETT */
    return biR;
#endif
}

#ifdef CONFIG_SSL_CERT_VERIFICATION
/**
 * @brief Perform a modular exponentiation using a temporary modulus.
 *
 * We need this function to check the signatures of certificates. The modulus
 * of this function is temporary as it's just used for authentication.
 * @param ctx [in]  The bigint session context.
 * @param bi  [in]  The bigint to perform the exp/mod.
 * @param bim [in]  The temporary modulus.
 * @param biexp [in] The bigint exponent.
 * @return The result of the mod exponentiation operation
 * @see bi_set_mod().
 */
bigint *bi_mod_power2(BI_CTX *ctx, bigint *bi, bigint *bim, bigint *biexp)
{
    bigint *biR, *tmp_biR;

    /* Set up a temporary bigint context and transfer what we need between
     * them. We need to do this since we want to keep the original modulus
     * which is already in this context. This operation is only called when
     * doing peer verification, and so is not expensive :-) */
    BI_CTX *tmp_ctx = bi_initialize();
    bi_set_mod(tmp_ctx, bi_clone(tmp_ctx, bim), BIGINT_M_OFFSET);
    tmp_biR = bi_mod_power(tmp_ctx, 
                bi_clone(tmp_ctx, bi), 
                bi_clone(tmp_ctx, biexp));
    biR = bi_clone(ctx, tmp_biR);
    bi_free(tmp_ctx, tmp_biR);
    bi_free_mod(tmp_ctx, BIGINT_M_OFFSET);
    bi_terminate(tmp_ctx);

    bi_free(ctx, bi);
    bi_free(ctx, bim);
    bi_free(ctx, biexp);
    return biR;
}
#endif

#ifdef CONFIG_BIGINT_CRT
/**
 * @brief Use the Chinese Remainder Theorem to quickly perform RSA decrypts.
 *
 * @param ctx [in]  The bigint session context.
 * @param bi  [in]  The bigint to perform the exp/mod.
 * @param dP [in] CRT's dP bigint
 * @param dQ [in] CRT's dQ bigint
 * @param p [in] CRT's p bigint
 * @param q [in] CRT's q bigint
 * @param qInv [in] CRT's qInv bigint
 * @return The result of the CRT operation
 */
bigint *bi_crt(BI_CTX *ctx, bigint *bi,
        bigint *dP, bigint *dQ,
        bigint *p, bigint *q, bigint *qInv)
{
    bigint *m1, *m2, *h;

    /* Montgomery has a condition the 0 < x, y < m and these products violate
     * that condition. So disable Montgomery when using CRT */
#if defined(CONFIG_BIGINT_MONTGOMERY)
    ctx->use_classical = 1;
#endif
    ctx->mod_offset = BIGINT_P_OFFSET;
    m1 = bi_mod_power(ctx, bi_copy(bi), dP);

    ctx->mod_offset = BIGINT_Q_OFFSET;
    m2 = bi_mod_power(ctx, bi, dQ);

    h = bi_subtract(ctx, bi_add(ctx, m1, p), bi_copy(m2), NULL);
    h = bi_multiply(ctx, h, qInv);
    ctx->mod_offset = BIGINT_P_OFFSET;
    h = bi_residue(ctx, h);
#if defined(CONFIG_BIGINT_MONTGOMERY)
    ctx->use_classical = 0;         /* reset for any further operation */
#endif
    return bi_add(ctx, m2, bi_multiply(ctx, q, h));
}
#endif
/** @} */





/**
 * Free up any RSA context resources.
 */
void RSA_free(RSA_CTX *rsa_ctx)
{
    BI_CTX *bi_ctx;
    if (rsa_ctx == NULL)                /* deal with ptrs that are null */
        return;

    bi_ctx = rsa_ctx->bi_ctx;

    bi_depermanent(rsa_ctx->e);
    bi_free(bi_ctx, rsa_ctx->e);
    bi_free_mod(rsa_ctx->bi_ctx, BIGINT_M_OFFSET);

    if (rsa_ctx->d)
    {
        bi_depermanent(rsa_ctx->d);
        bi_free(bi_ctx, rsa_ctx->d);
#ifdef CONFIG_BIGINT_CRT
        bi_depermanent(rsa_ctx->dP);
        bi_depermanent(rsa_ctx->dQ);
        bi_depermanent(rsa_ctx->qInv);
        bi_free(bi_ctx, rsa_ctx->dP);
        bi_free(bi_ctx, rsa_ctx->dQ);
        bi_free(bi_ctx, rsa_ctx->qInv);
        bi_free_mod(rsa_ctx->bi_ctx, BIGINT_P_OFFSET);
        bi_free_mod(rsa_ctx->bi_ctx, BIGINT_Q_OFFSET);
#endif
    }

    bi_terminate(bi_ctx);
    free(rsa_ctx);
}




void RSA_pub_key_new(RSA_CTX **ctx, 
        const uint8_t *modulus, int mod_len,
        const uint8_t *pub_exp, int pub_len)
{
    RSA_CTX *rsa_ctx;
    BI_CTX *bi_ctx;

    if (*ctx)   /* if we load multiple certs, dump the old one */
        RSA_free(*ctx);

    bi_ctx = bi_initialize();
    *ctx = (RSA_CTX *)calloc(1, sizeof(RSA_CTX));
    rsa_ctx = *ctx;
    rsa_ctx->bi_ctx = bi_ctx;
    rsa_ctx->num_octets = mod_len;
    rsa_ctx->m = bi_import(bi_ctx, modulus, mod_len);
    bi_set_mod(bi_ctx, rsa_ctx->m, BIGINT_M_OFFSET);
    rsa_ctx->e = bi_import(bi_ctx, pub_exp, pub_len);
    bi_permanent(rsa_ctx->e);
}



/**
 * Performs m = c^d mod n
 */
bigint *RSA_private(const RSA_CTX *c, bigint *bi_msg)
{
#ifdef CONFIG_BIGINT_CRT
    return bi_crt(c->bi_ctx, bi_msg, c->dP, c->dQ, c->p, c->q, c->qInv);
#else
    BI_CTX *ctx = c->bi_ctx;
    ctx->mod_offset = BIGINT_M_OFFSET;
    return bi_mod_power(ctx, bi_msg, c->d);
#endif
}


/**
 * @brief Use PKCS1.5 for decryption/verification.
 * @param ctx [in] The context
 * @param in_data [in] The data to decrypt (must be < modulus size-11)
 * @param out_data [out] The decrypted data.
 * @param out_len [int] The size of the decrypted buffer in bytes
 * @param is_decryption [in] Decryption or verify operation.
 * @return  The number of bytes that were originally encrypted. -1 on error.
 * @see http://www.rsasecurity.com/rsalabs/node.asp?id=2125
 */
int RSA_decrypt(const RSA_CTX *ctx, const uint8_t *in_data, 
                            uint8_t *out_data, int out_len, int is_decryption)
{
    const int byte_size = ctx->num_octets;
    int i = 0, size;
    bigint *decrypted_bi, *dat_bi;
    uint8_t *block = (uint8_t *)alloca(byte_size);
    int pad_count = 0;

    if (out_len < byte_size)        /* check output has enough size */
        return -1;

    memset(out_data, 0, out_len);   /* initialise */

    /* decrypt */
    dat_bi = bi_import(ctx->bi_ctx, in_data, byte_size);
#ifdef CONFIG_SSL_CERT_VERIFICATION
    decrypted_bi = is_decryption ?  /* decrypt or verify? */
            RSA_private(ctx, dat_bi) : RSA_public(ctx, dat_bi);
#else   /* always a decryption */
    decrypted_bi = RSA_private(ctx, dat_bi);
#endif

    /* convert to a normal block */
    bi_export(ctx->bi_ctx, decrypted_bi, block, byte_size);

    if (block[i++] != 0)             /* leading 0? */
        return -1;

#ifdef CONFIG_SSL_CERT_VERIFICATION
    if (is_decryption == 0) /* PKCS1.5 signing pads with "0xff"s */
    {
        if (block[i++] != 0x01)     /* BT correct? */
            return -1;

        while (block[i++] == 0xff && i < byte_size)
            pad_count++;
    }
    else                    /* PKCS1.5 encryption padding is random */
#endif
    {
        if (block[i++] != 0x02)     /* BT correct? */
            return -1;

        while (block[i++] && i < byte_size)
            pad_count++;
    }

    /* check separator byte 0x00 - and padding must be 8 or more bytes */
    if (i == byte_size || pad_count < 8) 
        return -1;

    size = byte_size - i;

    /* get only the bit we want */
    memcpy(out_data, &block[i], size);
    return size;
}

#ifdef CONFIG_SSL_FULL_MODE
/**
 * Used for diagnostics.
 */
void RSA_print(const RSA_CTX *rsa_ctx) 
{
    if (rsa_ctx == NULL)
        return;

    printf("-----------------   RSA DEBUG   ----------------\n");
    printf("Size:\t%d\n", rsa_ctx->num_octets);
    bi_print("Modulus", rsa_ctx->m);
    bi_print("Public Key", rsa_ctx->e);
    bi_print("Private Key", rsa_ctx->d);
}
#endif

/**
 * Performs c = m^e mod n
 */
bigint *RSA_public(const RSA_CTX * c, bigint *bi_msg)
{
    c->bi_ctx->mod_offset = BIGINT_M_OFFSET;
    return bi_mod_power(c->bi_ctx, bi_msg, c->e);
}

/**
 * Use PKCS1.5 for encryption/signing.
 * see http://www.rsasecurity.com/rsalabs/node.asp?id=2125
 */
int RSA_encrypt(const RSA_CTX *ctx, const uint8_t *in_data, uint16_t in_len, 
        uint8_t *out_data, int is_signing)
{
    int byte_size = ctx->num_octets;
    int num_pads_needed = byte_size-in_len-3;
    bigint *dat_bi, *encrypt_bi;

    /* note: in_len+11 must be > byte_size */
    out_data[0] = 0;     /* ensure encryption block is < modulus */

    if (is_signing)
    {
        out_data[1] = 1;        /* PKCS1.5 signing pads with "0xff"'s */
        memset(&out_data[2], 0xff, num_pads_needed);
    }
    else /* randomize the encryption padding with non-zero bytes */   
    {
        out_data[1] = 2;
        if (get_random_NZ(num_pads_needed, &out_data[2]) < 0)
            return -1;
    }

    out_data[2+num_pads_needed] = 0;
    memcpy(&out_data[3+num_pads_needed], in_data, in_len);

    /* now encrypt it */
    dat_bi = bi_import(ctx->bi_ctx, out_data, byte_size);
    encrypt_bi = is_signing ? RSA_private(ctx, dat_bi) : 
                              RSA_public(ctx, dat_bi);
    bi_export(ctx->bi_ctx, encrypt_bi, out_data, byte_size);

    /* save a few bytes of memory */
    bi_clear_cache(ctx->bi_ctx);
    return byte_size;
}

//----------------------------------------------------------------
int main() {
    BI_CTX *Xc = bi_initialize();
    BI_CTX *Yc = bi_initialize();
    bigint *X = alloc(Xc, (512/32/8) + 1);
    bigint *Y = alloc(Yc,  (512/32/8) + 1);
    uint8_t *data buffer[(512/8)];
    FILE *f;
    size_t sizz;

    while( 1 ) {
      f=fopen("/dev/random", "r");
      sizz=fread(buffer, sizeof(uint8_t), (512/8), f);
      fclose(f);
      X = bi_import(Xc, buffer, sizz);
      f=fopen("/dev/random", "r");
            /*
             * An necessary condition for Y and X = 2Y + 1 to be prime
             * is X = 2 mod 3 (which is equivalent to Y = 2 mod 3).
             * Make sure it is satisfied, while keeping X = 3 mod 4
             */

            X->comps[0] |= 2;

	    r=bi_divide(Xc, X, Y, 1);
            if( r == 0 ) X=bi_add(Xc, X, 8);
            else if( r == 1 ) X=bi_add(Xc, X, 4);

            /* Set Y = (X-1) / 2, which is X / 2 because X is odd */
	    
            MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &Y, X ) );
            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &Y, 1 ) );

            while( 1 )
            {
                /*
                 * First, check small factors for X and Y
                 * before doing Miller-Rabin on any of them
                 */
                if( ( ret = mpi_check_small_factors(  X         ) ) == 0 &&
                    ( ret = mpi_check_small_factors( &Y         ) ) == 0 &&
                    ( ret = mpi_miller_rabin(  X, f_rng, p_rng  ) ) == 0 &&
                    ( ret = mpi_miller_rabin( &Y, f_rng, p_rng  ) ) == 0 )
                    goto cleanup;

                if( ret != MBEDTLS_ERR_MPI_NOT_ACCEPTABLE )
                    goto cleanup;

                /*
                 * Next candidates. We want to preserve Y = (X-1) / 2 and
                 * Y = 1 mod 2 and Y = 2 mod 3 (eq X = 3 mod 4 and X = 2 mod 3)
                 * so up Y by 6 and X by 12.
                 */
                MBEDTLS_MPI_CHK( mbedtls_mpi_add_int(  X,  X, 12 ) );
                MBEDTLS_MPI_CHK( mbedtls_mpi_add_int( &Y, &Y, 6  ) );
            }
        }
    }

cleanup:

    mbedtls_mpi_free( &Y );

    return( ret );
}
  return 0;
}
