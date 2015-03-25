#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"

@interface SBSoundPreferences : NSObject
+ (void)userDefaultsDidChanged:(id)arg1;
@end

CFStringRef const kLockSoundsKey = CFSTR("lock-unlock");
CFStringRef const kSpringBoard = CFSTR("com.apple.springboard");

@interface LockSoundsSwitch : NSObject <FSSwitchDataSource>
@end

@implementation LockSoundsSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	Boolean keyExist;
	Boolean enabled = CFPreferencesGetAppBooleanValue(kLockSoundsKey, kSpringBoard, &keyExist);
	if (!keyExist)
		return FSSwitchStateOn;
	return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	CFBooleanRef enabled = newState == FSSwitchStateOn ? kCFBooleanTrue : kCFBooleanFalse;
	CFPreferencesSetAppValue(kLockSoundsKey, enabled, kSpringBoard);
	CFPreferencesAppSynchronize(kSpringBoard);
	[%c(SBSoundPreferences) userDefaultsDidChanged:nil];
}

@end

%hook SBSoundPreferences

+ (void)userDefaultsDidChanged:(id)arg1
{
	%orig;
	[[FSSwitchPanel sharedPanel] stateDidChangeForSwitchIdentifier:@"com.PS.LockSounds"];
}

%end
