#import <substrate.h>
#import <sys/utsname.h>
#import <Cephei/HBPreferences.h>
#import <AVFoundation/AVFoundation.h>
#import <InfoStats2/InfoStats2.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <CoreTelephony/CTMessageCenter.h>
#import "MLIMGURUploader/MLIMGURUploader.h"
#import "Reachability/Reachability.h"
#include <mach/mach_time.h>
#include <IOKit/hid/IOHIDEventSystem.h>
#import <UIKit/UIWindow+Private.h>
#import <Flipswitch/Flipswitch.h>
#import "libfireball/libfireball.h"
#import "IABlocks/UIAlertView+IABlocks.h"
#import <libcolorpicker.h>
#import <KarenLocalizer/KarenLocalizer.h>
#import "EmailSender/EmailSender.h"

@interface SBPowerDownController : UIViewController
- (void)pickpocketRespringNow;
@end

@interface SBLockHardwareButtonActions
- (void)performLongPressActions;
- (UIAlertController *)getShutdownPasswordAlert:(SBPowerDownController *)_powerDownController;
@end

@interface SBLockHardwareButton
@property(retain, nonatomic) SBLockHardwareButtonActions *buttonActions;
@end

@interface SpringBoard <AVSpeechSynthesizerDelegate>
@property(readonly, nonatomic) SBLockHardwareButton *lockHardwareButton;
@property(retain, nonatomic) SBPowerDownController *powerDownController;

- (void)powerDownCanceled:(id)arg1;
- (void)powerDown;
- (void)showShutdownAlert;
- (void)lockButtonWasHeld;
- (void)_simulateLockButtonPress;
- (UIAlertController *)getShutdownPasswordAlert:(SBPowerDownController *)_powerDownController;
- (void)_lockButtonUp:(struct __IOHIDEvent *)arg1 fromSource:(int)arg2;
-(void)pickpocketSendNewShutdownPasscodeMailTimer;
-(void)pickpocketTestMethod;
@end

@interface AVSystemController : NSObject
+ (id)sharedAVSystemController;
- (bool)setVolumeTo:(float)arg1 forCategory:(id)arg2;
- (bool)getVolume:(float*)arg1 forCategory:(id)arg2;
@end

@interface MFMutableMessageHeaders
- (void)setAddressListForSender:(id)arg1;
- (void)setAddressListForTo:(id)arg1;
- (void)setHeader:(id)arg1 forKey:(id)arg2;
@end

@interface MFMessageWriter
- (id)createMessageWithHtmlString:(id)arg1 attachments:(id)arg2 headers:(id)arg3;
@end

@interface MFMailDelivery
+ (id)newWithMessage:(id)arg1;
- (void)deliverAsynchronously;
@end

@interface MFOutgoingMessage
@end

@interface SBBacklightController
- (void)setBacklightFactor:(float)arg1 source:(int)arg2;
@end

@interface SBDeviceLockController
+ (id)sharedController;
- (BOOL)attemptDeviceUnlockWithPassword:(NSString *)passcode appRequested:(BOOL)requested;
@end

@interface BBBulletin
@property (nonatomic,copy) NSString *sectionID;
@property (nonatomic,copy) NSString *message;
@end

@interface SBAirplaneModeController
@property(nonatomic, getter=isInAirplaneMode) _Bool inAirplaneMode;
- (void)setInAirplaneMode:(BOOL)arg1;
@end

@interface WeatherLocationManager <CLLocationManagerDelegate>
+ (id)sharedWeatherLocationManager;
- (void)forceLocationUpdate;
- (CLLocationCoordinate2D*)lastLocationCoord;
@end

@interface SBDashBoardIdleTimerProvider
- (void)resetIdleTimer;
@end

@interface SBWiFiManager
- (id)currentNetworkName;
@end

@interface SBDashBoardView
- (void)pickpocketMailButtonReallyClicked;
@end