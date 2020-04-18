#include <jni.h>
//#include <android/log.h>
#include "libs/KittyMemory/MemoryPatch.h"
#include <libs/Substrate/CydiaSubstrate.h>
#include <memory.h>
#include <dlfcn.h>
#include <cstdio>
#include <cstdlib>
#import "include/Utils.h"

//Struct for patches
struct My_Patches {

    MemoryPatch GodMode, BypassAnticheat;
	
} my_cool_Patches;

float (*old_Player_getSkillCooldown)(void *instance);
float (Player_getSkillCooldown)(void *instance) {
	if(instance!=NULL) {
		return 0;
	}
	return old_Player_getSkillCooldown(instance);
}

int (*old_Player_getWeaponDamage)(void *instance);
int Player_getWeaponDamage(void *instance) {
	if(instance!=NULL) {
		return 1000000;
	}
	return old_Player_getWeaponDamage(instance);
}

__attribute__((constructor))
void libhook_main() {

    while(libBase == 0) { 
        libBase = get_libBase(libName); 
        sleep(1); 
    }   
	
	//KittyMemory patch example.
	my_cool_Patches.GodMode = MemoryPatch(libName, 0x1A2F7F4, "\xfa\x0f\xa0\xe3\x1e\xff\x2f\xe1", 8);	//mov r0, #0x3e8 	bx  lr
	my_cool_Patches.GodMode.Modify();
	
	my_cool_Patches.BypassAnticheat = MemoryPatch(libName, 0xF0458A5, "\x1e\xff\x2f\xe1", 4);	//bx lr
	my_cool_Patches.BypassAnticheat.Modify();
	
	//Usual Hook example.
	MSHookFunction((void *)getRealOffset(0x1A2E30A), (void *)Player_getSkillCooldown, (void **) &old_Player_getSkillCooldown);
    MSHookFunction((void *)getRealOffset(0x1A2EF90), (void *)Player_getWeaponDamage, (void **) &old_Player_getWeaponDamage);
}
