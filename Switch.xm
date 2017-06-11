#import "../../PS.h"
#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>

@interface SBSoundPreferences : NSObject
+ (void)userDefaultsDidChanged:(id)arg1;
@end

CFStringRef const kLockSoundsKey = isiOS10Up ? CFSTR("lock-audio") : CFSTR("lock-unlock");
CFStringRef const kDomain = isiOS10Up ? CFSTR("com.apple.preferences.sounds") : CFSTR("com.apple.springboard");

@interface LockSoundsSwitch : NSObject <FSSwitchDataSource>
@end

@implementation LockSoundsSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
    Boolean keyExist;
    Boolean enabled = CFPreferencesGetAppBooleanValue(kLockSoundsKey, kDomain, &keyExist);
    if (!keyExist)
        return FSSwitchStateOn;
    return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
    if (newState == FSSwitchStateIndeterminate)
        return;
    CFBooleanRef enabled = newState == FSSwitchStateOn ? kCFBooleanTrue : kCFBooleanFalse;
    CFPreferencesSetAppValue(kLockSoundsKey, enabled, kDomain);
    CFPreferencesAppSynchronize(kDomain);
    if (!isiOS10Up)
        [%c(SBSoundPreferences) userDefaultsDidChanged: nil];
}

@end

%hook SBSoundPreferences

+ (void)userDefaultsDidChanged: (id)arg1
{
    %orig;
    [[FSSwitchPanel sharedPanel] stateDidChangeForSwitchIdentifier:@"com.PS.LockSounds"];
}

%end

%ctor {
    if (!isiOS10Up) {
        %init;
    }
}
