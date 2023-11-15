/* KallistiOS ##version##

   kernel/romdisk/romdiskbase.c
   Copyright (C) 2023 Paul Cercueil
*/

#include <kos/fs_romdisk.h>

extern unsigned char romdisk[];

void *__kos_romdisk = romdisk;

extern int fs_romdisk_mount_builtin(void);

int (*fs_romdisk_mount_builtin_weak)(void) = fs_romdisk_mount_builtin;
