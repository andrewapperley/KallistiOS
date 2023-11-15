/* KallistiOS ##version##

   kernel/arch/dreamcast/include/dc/sq.h
   Copyright (C) 2000-2001 Andrew Kieschnick
   Copyright (C) 2023 Falco Girgis
   Copyright (C) 2023 Andy Barajas
   Copyright (C) 2023 Ruslan Rostovtsev
*/

/** \file    dc/sq.h
    \ingroup store_queues
    \brief   Functions to access the SH4 Store Queues.

    \author Andrew Kieschnick
*/

/** \defgroup  store_queues Store Queues
    \brief  SH4 CPU Peripheral for burst memory transactions.

    The store queues are a way to do efficient burst transfers from the CPU to
    external memory. They can be used in a variety of ways, such as to transfer
    a texture to PVR memory. The transfers are in units of 32-bytes, and the
    destinations must be 32-byte aligned.

    \note
    Mastery over knowing when and how to utilize the store queues is 
    important when trying to push the limits of the Dreamcast, specifically
    when transferring chunks of data between regions of memory. It is often
    the case that the DMA is faster for transactions which are consistently 
    large; however, the store queues tend to have better performance and 
    have less configuration overhead when bursting smaller chunks of data. 
*/

#ifndef __DC_SQ_H
#define __DC_SQ_H

#include <sys/cdefs.h>
__BEGIN_DECLS

#include <stdint.h>
#include <arch/types.h>
#include <arch/memory.h>

/** \brief   Store Queue 0 access register 
    \ingroup store_queues
*/
#define QACR0 (*(volatile uint32_t *)(void *)0xff000038)

/** \brief   Store Queue 1 access register 
    \ingroup store_queues  
*/
#define QACR1 (*(volatile uint32_t *)(void *)0xff00003c)

/** \brief   Set Store Queue QACR* registers
    \ingroup store_queues
*/
#define SET_QACR_REGS(dest0, dest1) \
    do { \
        QACR0 = ((uintptr_t)(dest0)) >> 24; \
        QACR1 = ((uintptr_t)(dest1)) >> 24; \
    } while(0)

/** \brief   Mask dest to Store Queue area as address
    \ingroup store_queues
*/
#define SQ_MASK_DEST_ADDR(dest) \
    (MEM_AREA_SQ_BASE | ((uintptr_t)(dest) & 0x03ffffe0))

/** \brief   Mask dest to Store Queue area as pointer
    \ingroup store_queues
*/
#define SQ_MASK_DEST(dest) \
    ((uint32_t *)(void *) SQ_MASK_DEST_ADDR(dest))

/** \brief  Lock Store Queues
    \ingroup store_queues
    
    Locks the store queues so that they cannot be used from another thread 
    until unlocked. 
    
    \warning
    This function is called automatically by the store queue API provided by KOS; 
    however, it must be called manually when driving the SQs directly from outside 
    of this API. 
    
    \sa sq_unlock()
*/
void sq_lock(void);

/** \brief  Unlock Store Queues
    \ingroup store_queues
    
    Unlocks the store queues so that they can be used from any thread. 
    
    \note 
    sq_lock() should've already been called previously.
    
    \warning
    sq_lock() and sq_unlock() are called automatically by the store queue API provided 
    by KOS; however, they must be called manually when driving the SQs directly from 
    outside this API.
    
    \sa sq_lock()
*/
void sq_unlock(void);

/** \brief   Copy a block of memory.
    \ingroup store_queues

    This function is similar to memcpy4(), but uses the store queues to do its
    work.

    \warning
    The dest pointer must be at least 32-byte aligned, the src pointer
    must be at least 4-byte aligned (8-byte aligned uses fast path), 
    and n must be a multiple of 32!

    \param  dest            The address to copy to (32-byte aligned).
    \param  src             The address to copy from (32-bit (4/8-byte) aligned).
    \param  n               The number of bytes to copy (multiple of 32).
    \return                 The original value of dest.

    \sa sq_cpy_pvr()
*/
void * sq_cpy(void *dest, const void *src, size_t n);

/** \brief   Set a block of memory to an 8-bit value.
    \ingroup store_queues

    This function is similar to calling memset(), but uses the store queues to
    do its work.

    \warning
    The dest pointer must be a 32-byte aligned with n being a multiple of 32, 
    and only the low 8-bits are used from c.

    \param  dest            The address to begin setting at (32-byte aligned).
    \param  c               The value to set (in the low 8-bits).
    \param  n               The number of bytes to set (multiple of 32).
    \return                 The original value of dest.

    \sa sq_set16(), sq_set32(), sq_set_pvr()
*/
void * sq_set(void *dest, uint32_t c, size_t n);

/** \brief   Set a block of memory to a 16-bit value.
    \ingroup store_queues

    This function is similar to calling memset2(), but uses the store queues to
    do its work.

    \warning
    The dest pointer must be a 32-byte aligned with n being a multiple of 32, 
    and only the low 16-bits are used from c.

    \param  dest            The address to begin setting at (32-byte aligned).
    \param  c               The value to set (in the low 16-bits).
    \param  n               The number of bytes to set (multiple of 32).
    \return                 The original value of dest.

    \sa sq_set(), sq_set32(), sq_set_pvr()
*/
void * sq_set16(void *dest, uint32_t c, size_t n);

/** \brief   Set a block of memory to a 32-bit value.
    \ingroup store_queues

    This function is similar to calling memset4(), but uses the store queues to
    do its work.

    \warning
    The dest pointer must be a 32-byte aligned with n being a multiple of 32!

    \param  dest            The address to begin setting at (32-byte aligned).
    \param  c               The value to set (all 32-bits).
    \param  n               The number of bytes to set (multiple of 32).
    \return                 The original value of dest.

    \sa sq_set(), sq_set16(), sq_set_pvr()
*/
void * sq_set32(void *dest, uint32_t c, size_t n);

/** \brief   Clear a block of memory.
    \ingroup store_queues

    This function is similar to calling memset() with a value to set of 0, but
    uses the store queues to do its work.

    \warning
    The dest pointer must be a 32-byte aligned with n being a multiple of 32!

    \param  dest            The address to begin clearing at (32-byte aligned).
    \param  n               The number of bytes to clear (multiple of 32).
*/
void sq_clr(void *dest, size_t n);

/** \brief   Copy a block of memory to VRAM
    \ingroup store_queues
    \author  TapamN

    This function is similar to sq_cpy(), but it has been
    optimized for writing to a destination residing within VRAM.

    \note
    TapamN has reported over a 2x speedup versus the regular
    sq_cpy() when using this function to write to VRAM.

    \warning
    This function cannot be used at the same time as a PVR DMA transfer.

    The dest pointer must be at least 32-byte aligned and reside 
    in video memory, the src pointer must be at least 8-byte aligned, 
    and n must be a multiple of 32.

    \param  dest            The address to copy to (32-byte aligned).
    \param  src             The address to copy from (32-bit (8-byte) aligned).
    \param  n               The number of bytes to copy (multiple of 32).
    \return                 The original value of dest.

    \sa sq_cpy()
*/
void * sq_cpy_pvr(void *dest, const void *src, size_t n);

/** \brief   Set a block of PVR memory to a 16-bit value.
    \ingroup store_queues

    This function is similar to sq_set16(), but it has been
    optimized for writing to a destination residing within VRAM.

    \warning
    This function cannot be used at the same time as a PVR DMA transfer.
    
    The dest pointer must be at least 32-byte aligned and reside in video 
    memory, n must be a multiple of 32 and only the low 16-bits are used 
    from c.

    \param  dest            The address to begin setting at (32-byte aligned).
    \param  c               The value to set (in the low 16-bits).
    \param  n               The number of bytes to set (multiple of 32).
    \return                 The original value of dest.

    \sa sq_set(), sq_set16(), sq_set32()
*/
void * sq_set_pvr(void *dest, uint32_t c, size_t n);

__END_DECLS

#endif
