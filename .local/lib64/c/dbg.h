#ifndef __DBG_H__
#define __DBG_H__

#include <errno.h>
#include <stdio.h>
#include <string.h>

#ifdef NDEBUG
#define debug(fmt, ...)
#else
#define debug(fmt, args...)                                                    \
  fprintf(stderr, "DEBUG   %s:%d: " fmt "\n", __FILE__, __LINE__, ##args)
#endif

#define clean_errno() (errno == 0 ? "None" : strerror(errno))

#define log_err(fmt, args...)                                                  \
  fprintf(stderr, "[ERROR] (%s:%d: errno: %s)" fmt "\n", __FILE__, __LINE__,   \
          clean_errno(), ##args)
#define log_warn(fmt, args...)                                                 \
  fprintf(stderr, "[WARN]  (%s:%d: errno: %s)" fmt "\n", __FILE__, __LINE__,   \
          clean_errno(), ##args)
#define log_info(fmt, args...)                                                 \
  fprintf(stderr, "[INFO]  (%s:%d: errno: %s)" fmt "\n", __FILE__, __LINE__,   \
          clean_errno(), ##args)

#define check(test, fmt, args...)                                              \
  do {                                                                         \
    if (!(test)) {                                                             \
      log_err(fmt, ##args);                                                    \
      errno = 0;                                                               \
      goto error;                                                              \
    }                                                                          \
  } while (0)

#define sentinel(fmt, args...)                                                 \
  do {                                                                         \
    log_err(fmt, ##args);                                                      \
    errno = 0;                                                                 \
    goto error;                                                                \
  } while (0)

#define check_mem(val) check((val), "Out of memory!")

#define check_debug(test, fmt, args...)                                        \
  do {                                                                         \
    if (!(test)) {                                                             \
      debug(fmt, ##args);                                                      \
      errno = 0;                                                               \
      goto error;                                                              \
    }                                                                          \
  } while (0)

#endif // !__DBG_H__
