@echo off
setlocal enabledelayedexpansion
for /f %%a in (params.txt) do set checkContent=%%a
if not !checkContent! gtr 0 (
set /p "np=Set your ndk path: "
set /p  "pp=Set your project path: "
) else (
for /f "delims=" %%x in (params.txt) do set pp=%%x
set /p np=<params.txt
echo ndk path: !np!
echo project path: !pp!
)
echo.
echo What architecture do you need ?
echo 1. armeabi-v7a 2. arm64-v8a 3. All
goto archCheck
:archPrompt
set /p "archt=Enter choice: "
:archCheck
if not defined archt goto :archPrompt

cd %np%

if %archt%==1 (
echo.
call ndk-build NDK_PROJECT_PATH=%pp%\x32 NDK_APPLICATION_MK=%pp%\x32\jni\Application.mk
goto :onEnd
) else if %archt%==2 (
echo.
call ndk-build NDK_PROJECT_PATH=%pp%\x64 NDK_APPLICATION_MK=%pp%\x64\jni\Application.mk
goto :onEnd
) else if %archt%==3 (
echo.
call ndk-build NDK_PROJECT_PATH=%pp%\x64 NDK_APPLICATION_MK=%pp%\x64\jni\Application.mk
goto :onEnd
:step2
echo.
call ndk-build NDK_PROJECT_PATH=%pp%\x32 NDK_APPLICATION_MK=%pp%\x32\jni\Application.mk
set /a archt=0
goto :onEnd
) else (
echo.
echo User imput not valid.
goto :archPrompt
)

:onEnd
if "%errorlevel%"=="0" (echo Build successful.) else (echo Build failed.)
if %archt%==3 goto step2

echo.
pause
