#import <Foundation/Foundation.h>
#import "headers.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <substrate.h>

BOOL unlock(char* c_code) {
	NSString *passcode = [NSString stringWithUTF8String: c_code];
	id awayController_ = objc_getClass("CSAwayController") ?: objc_getClass("SBAwayController");
	if (awayController_) {
		if ([awayController_ respondsToSelector:@selector(sharedAwayController)]) {

			SBAwayController *awayController = [awayController_ sharedAwayController];

			if ([awayController respondsToSelector:@selector(attemptDeviceUnlockWithPassword:lockViewOwner:)]) {
			return [awayController attemptDeviceUnlockWithPassword:passcode lockViewOwner:nil];

			} else {
				NSLog (@"[awayController respondsToSelector:@selector(attemptDeviceUnlockWithPassword:lockViewOwner:)] = flase");
			}
		} else {
			NSLog (@"[awayController_ respondsToSelector:@selector(sharedAwayController)] == false");
		}

	} else {
		NSLog (@"awayController_ == false");
	}
	//[(SBLockScreenViewController*)[[objc_getClass("SBLockScreenManager") sharedInstance] lockScreenViewController] passcodeLockViewPasscodeEntered:nil];
	//[(SBLockScreenManager *)[objc_getClass("SBLockScreenManager") sharedInstance] attemptUnlockWithPasscode:[NSString stringWithFormat:@"%@", self.devicePasscode]];
	return NO;
}

int main (int argc, const char * argv[]) {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog (@"start");
	if (argc < 2) {
		NSLog (@"no pass provided");
	} else {
		NSLog ([NSString stringWithFormat:@"You entered %@", unlock(argv[1])]);
	}
	NSLog (@"end");
	[pool drain];
	return 0;
}
