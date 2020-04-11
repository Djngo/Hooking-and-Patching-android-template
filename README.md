# Hooking-and-Patching-android-template
This is a template for the usage of Cydia Substrate and KittyMemory. **(Does not support arm64)**

It is base on an already made hooking template by joeyjurjens/Ted2 here https://github.com/joeyjurjens/Android-Hooking-Template

And the KittyMemory repo by MJx0 here https://github.com/MJx0/KittyMemory

<br>

## Installation
* Download this github files and unzip it.
* Download Android NDK, Revision 16b from: https://developer.android.com/ndk/downloads/older_releases
<br>

## How to use
* [main.cpp](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/jni/main.cpp) This is where you will write your hooks and patches.
* [Utils.h](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/jni/Utils.h) Edit the targeted library here.

**Change the outputed library name:**
* [Android.mk](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/jni/Android.mk) Replace the default name by whatever you want at "LOCAL_MODULE :="
* [libLoader$1.smali](https://github.com/Djngo/Hooking-and-Patching-android-template/blob/master/Smali%20Files/libLoader%241.smali) Change it in this file as well. (line 38)
<br>

## Loading the lib.so
First we need to compile our project.
* Edit compile.bat & paste your ndk-build **path location** in the first line and the **project location** next to "NDK_PROJECT_PATH=".
* Once compiled you'll have 2 new file in your project **libs** and **obj**.
In order to load your <b>lib.so</b>, you'll need to decompile the apk, you can use Apk Easy Tool for this.
* Go to *Libs* and copy the created lib.so in the Lib folder of your game.
* Navigate to "<b>/smali/com</b>" & create a folder called "<b>loadLib</b>"
* Copy the two .smali files provided in the smali folder from this Git, inside of that folder.
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
