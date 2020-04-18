# Hooking-and-Patching-android-template
This is a template for the usage of Cydia Substrate and KittyMemory.

It is based on an already made hooking template by joeyjurjens/Ted2 here https://github.com/joeyjurjens/Android-Hooking-Template

And the KittyMemory repo by MJx0 here https://github.com/MJx0/KittyMemory

**NEW** Added hook alternative for aarch64 from this repo https://github.com/Rprop/And64InlineHook

<br>

## Installation
* Download this github files and unzip it.
* Download Android NDK, Revision 16b from: https://developer.android.com/ndk/downloads/older_releases
<br>

## How to use
* [x32/main.cpp](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/x32/jni/src/main.cpp) This is where you will write your hooks and patches for armeabi-7va.
* [x64/main.cpp](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/x64/jni/src/main.cpp) This is where you will write your hooks and patches for arm64-v8a (I added an example for the hook alternative but it works exactly like mshook).
* [Utils.h](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/x32/jni/include/Utils.h) Edit the targeted library here. (In x64 too)

**Change the outputed library name:**
* [Android.mk](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/x32/jni/Android.mk) Replace the default name by whatever you want at "LOCAL_MODULE :="
* [Android.mk](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/x64/jni/Android.mk) Do the same for the other folder (x64)
* [libLoader$1.smali](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/Smali%20Files/loadLib/libLoader%241.smali) Change it in this file as well. (line 38)
<br>

## Loading the lib.so
First we need to compile our project.
* Edit params.txt & paste your ndk-build **path location** on the very first line and the **project location** on the second line like I did.
* Start Build.bat and follow instructions.
* Once compiled you'll have 2 new file in x32 and x64 named **libs** and **obj**.
In order to load your <b>lib.so</b>, you'll need to decompile the apk, you can use Apk Easy Tool for this.
* Go to *Libs* and copy the created lib.so in the Lib folder of your game.
* Navigate to "<b>/smali/com</b>" & copy the loadLib from this git inside of that folder.
* Open the AndroidManifest.xml file in the decompiled apk and search this 

```xml
android:name="com.unity3d.player.UnityPlayerActivity" 
```

  it will give us the path of the MainActivity so in our case it's at  "<b>com/unity3d/player/UnityPlayerActivity</b>"
* Open that file with Notepad++ or any text editing software and search something like this:

```java
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2
```

* Once found, paste this code under .locals 2:

```java
invoke-static {}, Lcom/loadLib/libLoader;->loadLib()V
```
* Step 1: Recompile the apk
* Step 2: Profit
<br>

## Useful links
For Cydia Substrate:
* http://www.cydiasubstrate.com/api/c/MSHookFunction/
* https://guidedhacking.com/threads/android-function-pointers-hooking-template-tutorial.14771/

If you're here or if you made mod menus before you probably already know how to use KittyMemory.
