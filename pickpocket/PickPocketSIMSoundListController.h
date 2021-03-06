#import <CepheiPrefs/HBRootListController.h>
#import <AVFoundation/AVFoundation.h>

@interface PickPocketSIMSoundListController : HBRootListController {
    NSArray *directoryContent;
    AVAudioPlayer* audioPlayer;
}

- (NSArray *)getValues:(id)target;
- (void)previewAndSet:(id)value forSpecifier:(id)specifier;
@end
