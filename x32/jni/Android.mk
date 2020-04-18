LOCAL_PATH := $(call my-dir)
MAIN_LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := yeet

LOCAL_CPPFLAGS := -std=c++11
LOCAL_CFLAGS := -Wno-error=format-security -fpermissive -Wc++11-extensions -Wno-absolute-value
LOCAL_CFLAGS += -fno-rtti -fno-exceptions

LOCAL_C_INCLUDES += $(MAIN_LOCAL_PATH)

LOCAL_SRC_FILES := src/main.cpp \
				   libs/Substrate/hde64.c \
                   libs/Substrate/SubstrateDebug.cpp \
                   libs/Substrate/SubstrateHook.cpp \
                   libs/Substrate/SubstratePosixMemory.cpp \
				   libs/KittyMemory/KittyMemory.cpp \
				   libs/KittyMemory/MemoryPatch.cpp \

LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_LIBRARY)
