//
//  UIAlertView+IABlocks.m
//
//  This is free and unencumbered software released into the public domain.
//
//  Anyone is free to copy, modify, publish, use, compile, sell, or
//  distribute this software, either in source code form or as a compiled
//  binary, for any purpose, commercial or non-commercial, and by any
//  means.
//
//  In jurisdictions that recognize copyright laws, the author or authors
//  of this software dedicate any and all copyright interest in the
//  software to the public domain. We make this dedication for the benefit
//  of the public at large and to the detriment of our heirs and
//  successors. We intend this dedication to be an overt act of
//  relinquishment in perpetuity of all present and future rights to this
//  software under copyright law.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//
//  For more information, please refer to <http://unlicense.org>
//

#import "UIAlertView+IABlocks.h"


#define IAAlertViewBlocksViewTag                (0x14151337)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark -
@interface IAAlertViewBlocksView : UIView <UIAlertViewDelegate> {
    IAAlertViewHandler          _cancelHandler;
    BOOL                        (^_shouldEnableFirstOtherButtonHandler)(UIAlertView* alert);
    IAAlertViewHandler          _buttonHandler;
    NSMutableArray*             _buttonHandlers;
    IAAlertViewHandler          _willPresentHandler;
    IAAlertViewHandler          _didPresentHandler;
    IAAlertViewHandler          _willDismissHandler;
    IAAlertViewHandler          _didDismissHandler;
}

@property (copy, nonatomic)     IAAlertViewHandler      cancelHandler;
@property (copy, nonatomic)     BOOL                    (^shouldEnableFirstOtherButtonHandler)(UIAlertView* alert);
@property (copy, nonatomic)     IAAlertViewHandler      buttonHandler;
@property (copy, nonatomic)     IAAlertViewHandler      willPresentHandler;
@property (copy, nonatomic)     IAAlertViewHandler      didPresentHandler;
@property (copy, nonatomic)     IAAlertViewHandler      willDismissHandler;
@property (copy, nonatomic)     IAAlertViewHandler      didDismissHandler;

- (IAAlertViewHandler)handlerForButtonAtIndex:(NSInteger)buttonIndex;
- (void)setHandler:(IAAlertViewHandler)handler forButtonAtIndex:(NSInteger)buttonIndex;

- (void)clearAllHandlers;

@end



#pragma mark -
@implementation UIAlertView (IABlocks)

#pragma mark -
#pragma mark Lifecycle

- (id)initWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ... {
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        if (otherButtonTitles) {
            va_list otherButtonTitlesList;
            va_start(otherButtonTitlesList, otherButtonTitles);
            NSString* otherButtonTitle;
            while ((otherButtonTitle = va_arg(otherButtonTitlesList, NSString*)) != nil) {
                [self addButtonWithTitle:otherButtonTitle];
            }
            va_end(otherButtonTitlesList);
        }
        
        IAAlertViewBlocksView* blocksView = [[IAAlertViewBlocksView alloc] init];
        [self setDelegate:blocksView];
        [self addSubview:blocksView];
    }
    return self;
}


#pragma mark -
#pragma mark Properties

- (BOOL)isBlocksEnabled {
    return ([self viewWithTag:IAAlertViewBlocksViewTag] != nil);
}

- (void)setBlocksEnabled:(BOOL)blocksEnabled {
    IAAlertViewBlocksView* blocksView = (IAAlertViewBlocksView*)[self viewWithTag:IAAlertViewBlocksViewTag];
    if (blocksEnabled) {
        if (!blocksView) {
            blocksView = [[IAAlertViewBlocksView alloc] init];
            [self setDelegate:blocksView];
            [self addSubview:blocksView];
        }
    } else {
        if (blocksView) {
            if ([self delegate] == blocksView)
                [self setDelegate:nil];
            [blocksView removeFromSuperview];
        }
    }
}

- (IAAlertViewHandler)cancelHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        return [blocksView cancelHandler];
    else
        return nil;
}

- (void)setCancelHandler:(IAAlertViewHandler)cancelHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        [blocksView setCancelHandler:cancelHandler];
}

- (BOOL (^)(UIAlertView*))shouldEnableFirstOtherButtonHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        return [blocksView shouldEnableFirstOtherButtonHandler];
    else
        return nil;
}

- (void)setShouldEnableFirstOtherButtonHandler:(BOOL (^)(UIAlertView*))shouldEnableFirstOtherButtonHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        [blocksView setShouldEnableFirstOtherButtonHandler:shouldEnableFirstOtherButtonHandler];
}

- (IAAlertViewHandler)buttonHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        return [blocksView buttonHandler];
    else
        return nil;
}

- (void)setButtonHandler:(IAAlertViewHandler)buttonHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        [blocksView setButtonHandler:buttonHandler];
}

- (IAAlertViewHandler)willPresentHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        return [blocksView willPresentHandler];
    else
        return nil;
}

- (void)setWillPresentHandler:(IAAlertViewHandler)presentHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        [blocksView setWillPresentHandler:presentHandler];
}

- (IAAlertViewHandler)didPresentHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        return [blocksView didPresentHandler];
    else
        return nil;
}

- (void)setDidPresentHandler:(IAAlertViewHandler)presentHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        [blocksView setDidPresentHandler:presentHandler];
}

- (IAAlertViewHandler)willDismissHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        return [blocksView willDismissHandler];
    else
        return nil;
}

- (void)setWillDismissHandler:(IAAlertViewHandler)dismissHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        [blocksView setWillDismissHandler:dismissHandler];
}

- (IAAlertViewHandler)didDismissHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        return [blocksView didDismissHandler];
    else
        return nil;
}

- (void)setDidDismissHandler:(IAAlertViewHandler)dismissHandler {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        [blocksView setDidDismissHandler:dismissHandler];
}


#pragma mark -
#pragma mark Public methods

- (IAAlertViewHandler)handlerForButtonAtIndex:(NSInteger)buttonIndex {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        return [blocksView handlerForButtonAtIndex:buttonIndex];
    else
        return nil;
}

- (void)setHandler:(IAAlertViewHandler)handler forButtonAtIndex:(NSInteger)buttonIndex {
    IAAlertViewBlocksView* blocksView = [self findBlocksView];
    if (blocksView)
        [blocksView setHandler:handler forButtonAtIndex:buttonIndex];
}


#pragma mark -
#pragma mark Private methods

- (IAAlertViewBlocksView*)findBlocksView {
    IAAlertViewBlocksView* blocksView = (IAAlertViewBlocksView*)[self viewWithTag:IAAlertViewBlocksViewTag];
    if (!blocksView)
        NSLog(@"WARNING: Blocks are currently not enabled for %@. Either use initWithTitle:message:cancelButtonTitle:otherButtonTitles: or call setBlocksEnabled:YES.", self);
    return blocksView;
}

@end



#pragma mark -
@implementation IAAlertViewBlocksView

#pragma mark -
#pragma mark Lifecycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:NO];
        [self setTag:IAAlertViewBlocksViewTag];
        
        _buttonHandlers = [[NSMutableArray alloc] init];
        
        [self clearAllHandlers];
    }
    return self;
}

- (void)dealloc {
}


#pragma mark -
#pragma mark Properties

@synthesize cancelHandler = _cancelHandler;
@synthesize shouldEnableFirstOtherButtonHandler = _shouldEnableFirstOtherButtonHandler;
@synthesize buttonHandler = _buttonHandler;
@synthesize willPresentHandler = _willPresentHandler;
@synthesize didPresentHandler = _didPresentHandler;
@synthesize willDismissHandler = _willDismissHandler;
@synthesize didDismissHandler = _didDismissHandler;


#pragma mark -
#pragma mark UView

- (void)willMoveToSuperview:(UIView*)newSuperview {
    [self clearAllHandlers];
}


#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_buttonHandler)
        _buttonHandler(alertView, buttonIndex);
    
    if (buttonIndex >= 0) {
        IAAlertViewHandler handler = [self handlerForButtonAtIndex:buttonIndex];
        if (handler)
            handler(alertView, buttonIndex);
        
        if (buttonIndex == [alertView cancelButtonIndex] && _cancelHandler)
            _cancelHandler(alertView, buttonIndex);
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView*)alertView {
    if (_shouldEnableFirstOtherButtonHandler)
        return _shouldEnableFirstOtherButtonHandler(alertView);
    else
        return YES;
}

- (void)willPresentAlertView:(UIAlertView*)alertView {
    if (_willPresentHandler)
        _willPresentHandler(alertView, -1);
}

- (void)didPresentAlertView:(UIAlertView*)alertView {
    if (_didPresentHandler)
        _didPresentHandler(alertView, -1);
}

- (void)alertView:(UIAlertView*)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (_willDismissHandler)
        _willDismissHandler(alertView, buttonIndex);
}

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (_didDismissHandler)
        _didDismissHandler(alertView, buttonIndex);
}

- (void)alertViewCancel:(UIAlertView*)alertView {
    NSInteger cancelButtonIndex = [alertView cancelButtonIndex];
    if (_buttonHandler && cancelButtonIndex >= 0)
        _buttonHandler(alertView, cancelButtonIndex);
    
    if (cancelButtonIndex >= 0) {
        IAAlertViewHandler handler = [self handlerForButtonAtIndex:cancelButtonIndex];
        if (handler)
            handler(alertView, cancelButtonIndex);
    }
    
    if (_cancelHandler)
        _cancelHandler(alertView, -1);
}



#pragma mark -
#pragma mark Public methods

- (IAAlertViewHandler)handlerForButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex < 0)
        @throw [NSException exceptionWithName:NSRangeException reason:@"Button index can't be less than 0." userInfo:nil];
    
    if (buttonIndex < [_buttonHandlers count]) {
        id handler = [_buttonHandlers objectAtIndex:buttonIndex];
        if ([handler isKindOfClass:[NSNull class]])
            return nil;
        else
            return handler;
    } else {
        return nil;
    }
}

- (void)setHandler:(IAAlertViewHandler)handler forButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex < 0)
        @throw [NSException exceptionWithName:NSRangeException reason:@"Button index can't be less than 0." userInfo:nil];
    
    while ([_buttonHandlers count] < buttonIndex)
        [_buttonHandlers addObject:[NSNull null]];
    
    if (buttonIndex == [_buttonHandlers count])
        [_buttonHandlers addObject:(handler ? [handler copy] : [NSNull null])];
    else
        [_buttonHandlers replaceObjectAtIndex:buttonIndex withObject:(handler ? [handler copy] : [NSNull null])];
}

- (void)clearAllHandlers {
    _cancelHandler = nil;
    _shouldEnableFirstOtherButtonHandler = nil;
    _buttonHandler = nil;
    [_buttonHandlers removeAllObjects];
    _willPresentHandler = nil;
    _didPresentHandler = nil;
    _willDismissHandler = nil;
    _didDismissHandler = nil;
}

@end

#pragma clang diagnostic pop
