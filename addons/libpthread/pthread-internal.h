/* KallistiOS ##version##

   pthread-internal.h
   Copyright (C) 2023 Lawrence Sebald
*/

#ifndef __PTHREAD_INTERNAL_H
#define __PTHREAD_INTERNAL_H

#define __PTHREAD_HAVE_ATTR_TYPE    1
#define __PTHREAD_HAVE_MUTEX_TYPE   1
#define __PTHREAD_HAVE_COND_TYPE    1
#define __PTHREAD_HAVE_RWLOCK_TYPE  1

#define __PTHREAD_ATTR_SIZE         32
#define __PTHREAD_MUTEX_SIZE        32
#define __PTHREAD_COND_SIZE         16
#define __PTHREAD_RWLOCK_SIZE       32

#include <sys/cdefs.h>
#include <kos/thread.h>
#include <kos/cond.h>
#include <kos/mutex.h>
#include <kos/rwsem.h>

typedef union pthread_attr_t {
    kthread_attr_t attr;
    unsigned char __data[__PTHREAD_ATTR_SIZE];
    long int __align;
} pthread_attr_t;

typedef union pthread_mutex_t {
    mutex_t mutex;
    unsigned char __data[__PTHREAD_MUTEX_SIZE];
    long int __align;
} pthread_mutex_t;

typedef union pthread_cond_t {
    condvar_t cond;
    unsigned char __data[__PTHREAD_COND_SIZE];
    long int __align;
} pthread_cond_t;

typedef union pthread_rwlock_t {
    rw_semaphore_t rwsem;
    unsigned char __data[__PTHREAD_RWLOCK_SIZE];
    long int __align;
} pthread_rwlock_t;

/* Clever trick to make sure that we don't botch any of these structures in the
   future... Taken from this stackoverflow thread:
   https://stackoverflow.com/questions/4079243 */
#define STATIC_ASSERT(condition) \
    typedef char __CONCAT(_static_assert_, __LINE__)[ (condition) ? 1 : -1];

STATIC_ASSERT(sizeof(pthread_attr_t) == __PTHREAD_ATTR_SIZE)
STATIC_ASSERT(sizeof(pthread_mutex_t) == __PTHREAD_MUTEX_SIZE)
STATIC_ASSERT(sizeof(pthread_cond_t) == __PTHREAD_COND_SIZE)
STATIC_ASSERT(sizeof(pthread_rwlock_t) == __PTHREAD_RWLOCK_SIZE)

#undef STATIC_ASSERT

#endif /* !__PTHREAD_INTERNAL_H */
