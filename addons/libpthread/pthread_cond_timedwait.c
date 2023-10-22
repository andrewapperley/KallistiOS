/* KallistiOS ##version##

   pthread_cond_timedwait.c
   Copyright (C) 2023 Lawrence Sebald

*/

#include "pthread-internal.h"
#include <pthread.h>
#include <errno.h>
#include <sys/time.h>
#include <kos/cond.h>

int pthread_cond_timedwait(pthread_cond_t *__RESTRICT cond,
                           pthread_mutex_t *__RESTRICT mutex,
                           const struct timespec *__RESTRICT abstime) {
    int old, rv = 0;
    int tmo;
    struct timeval ctv;

    if(!mutex || !abstime)
        return EFAULT;

    if(abstime->tv_nsec < 0 || abstime->tv_nsec > 1000000000L)
        return EINVAL;

    old = errno;

    /* Figure out the timeout we need to provide. */
    gettimeofday(&ctv, NULL);

    tmo = abstime->tv_sec - ctv.tv_sec;
    tmo += abstime->tv_nsec / (1000 * 1000) - ctv.tv_usec / 1000;

    if(tmo <= 0)
        return ETIMEDOUT;

    if(cond_wait_timed(&cond->cond, &mutex->mutex, tmo))
        rv = errno;

    errno = old;
    return rv;
}
