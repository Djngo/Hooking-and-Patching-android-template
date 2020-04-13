@echo off
cd (PUT YOUR NDK PATH HERE)
call ndk-build NDK_PROJECT_PATH=(PUT YOUR PROJECT PATH HERE) NDK_APPLICATION_MK=(PUT YOUR PROJECT PATH HERE)\jni\Application.mk

if "%errorlevel%"=="0" echo Build successful.

pause