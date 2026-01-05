APP_ABI := arm64-v8a
APP_PIE := true
APP_PLATFORM := android-21
APP_CFLAGS := -Wall -O2 -fomit-frame-pointer -flto -DPSTM_NO_ASM -DDISABLE_PSTM_X86
# Disable all security features
APP_CFLAGS += -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-stack-protector -U_FORTIFY_SOURCE
APP_LDFLAGS := -flto -Wl,--icf=all
APP_SUPPORT_FLEXIBLE_PAGE_SIZES := true

ifeq ($(OS),Windows_NT)
APP_SHORT_COMMANDS := true
endif

