/* SPDX-License-Identifier: LGPL-2.1+ */
#pragma once

#include <inttypes.h>
#include <sys/types.h>

int load_key_file(
                const char *key_file,
                char **search_path,
                size_t key_file_size,
                uint64_t key_file_offset,
                void **ret_key,
                size_t *ret_key_size);

#if HAVE_LIBCRYPTSETUP
#include <libcryptsetup.h>

/* These next two are defined in libcryptsetup.h from cryptsetup version 2.3.4 forwards. */
#ifndef CRYPT_ACTIVATE_NO_READ_WORKQUEUE
#define CRYPT_ACTIVATE_NO_READ_WORKQUEUE (1 << 24)
#endif
#ifndef CRYPT_ACTIVATE_NO_WRITE_WORKQUEUE
#define CRYPT_ACTIVATE_NO_WRITE_WORKQUEUE (1 << 25)
#endif
