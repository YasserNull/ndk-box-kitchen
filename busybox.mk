MINORLEVEL := 1
BB_VER := "$(VERSION).$(PATCHLEVEL).$(SUBLEVEL).$(MINORLEVEL) YasserNull"

include $(CLEAR_VARS)
LOCAL_MODULE := busybox
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
ifneq ($(DISABLE_SELINUX),1)
LOCAL_STATIC_LIBRARIES := libselinux
endif
LOCAL_LDFLAGS := -pie -Wl,--wrap=realpath -Wl,--wrap=rename -Wl,--wrap=renameat -Wl,--wrap=getaddrinfo
LOCAL_CFLAGS := \
-fPIE \
-w -include include/autoconf.h -D__USE_BSD -D__USE_GNU \
-DBB_VER=\"$(BB_VER)\" -DBB_BT=AUTOCONF_TIMESTAMP

LOCAL_SRC_FILES := \
