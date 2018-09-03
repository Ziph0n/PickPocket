#include "PickPocketSIMSoundListController.h"

@implementation PickPocketSIMSoundListController

+ (NSString *)hb_specifierPlist {
    return @"SIMSound";
}

+ (UIColor *)hb_tintColor {
    return [UIColor colorWithRed:252.f / 255.f green:89.f / 255.f blue:121.f / 255.f alpha:1];
}

- (void)previewAndSet:(id)value forSpecifier:(id)specifier{
    [super setPreferenceValue:value specifier:specifier];

    if (audioPlayer != nil) {
        if ([audioPlayer isPlaying]) {
            [audioPlayer stop];
        }
    }

    NSString *path = [NSString stringWithFormat:@"/Library/Application Support/PickPocket/Sounds/%@", value];
    NSURL *file = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}

- (NSArray *)getValues:(id)target{
    directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Library/Application Support/PickPocket/Sounds/" error:NULL];
    NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None",nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];
    for (NSURL *fileURL in [directoryContent filteredArrayUsingPredicate:predicate]) {
        [listing addObject:fileURL];
    }
    return listing;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (audioPlayer != nil) {
        [audioPlayer stop];
    }
}

@end
