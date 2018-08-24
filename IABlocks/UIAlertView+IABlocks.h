//
//  UIAlertView+IABlocks.h
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

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

/**
 The block for UIAlertView events.
 
 @param alert The alert view that fired the event.
 @param buttonIndex The index of the button related to the event. May be -1 if it does not apply.
 */
typedef void (^IAAlertViewHandler)(UIAlertView* alert, NSInteger buttonIndex);



/**
 This category adds support for blocks to UIAlertViews, making it unnecessary to use delegates.
 
 Using the initializer initWithTitle:message:cancelButtonTitle:otherButtonTitles:... automatically enables
 blocks for the alert view, but they can also be toggled on or of using the blocksEnabled property. Note
 that when blocks are enabled you SHOULD NOT set the delegate to something else. This implementation
 depends on a private class that acts as the delegate when blocks are enabled. Setting a different delegate
 will have undefined results.
 */
@interface UIAlertView (IABlocks)

/**
 Convenience method for initializing an alert view with blocks enabled.
 
 @param title The string that appears in the receiver’s title bar.
 @param message Descriptive text that provides more details than the title.
 @param cancelButtonTitle The title of the cancel button or nil if there is no cancel button.
 Using this argument is equivalent to setting the cancel button index to the value returned by invoking addButtonWithTitle: specifying this title.
 @param otherButtonTitles The title of another button.
 Using this argument is equivalent to invoking addButtonWithTitle: with this title to add more buttons.
 @param ... Titles of additional buttons to add to the receiver, terminated with nil.
 @return Newly initialized alert view with blocks enabled.
 */
- (id)initWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/** A Boolean value indicating whether blocks are enabled. */
@property (nonatomic, getter = isBlocksEnabled) BOOL    blocksEnabled;

/**
 The cancel handler will be called when the alert is cancelled, either by the system or
 by the user tapping the cancel button.
 
 The buttonIndex parameter of the handler is -1 if the alert is cancelled by the system, or
 equal to cancelButtonIndex if the user tapped the cancel button.
 
 See [UIAlertViewDelegate alertViewCancel:].
 */
@property (copy, nonatomic)     IAAlertViewHandler      cancelHandler;

/** See [UIAlertViewDelegate alertViewShouldEnableFirstOtherButton:]. */
@property (copy, nonatomic)     BOOL                    (^shouldEnableFirstOtherButtonHandler)(UIAlertView* alert);

/** See [UIAlertViewDelegate alertView:clickedButtonAtIndex:]. */
@property (copy, nonatomic)     IAAlertViewHandler      buttonHandler;

/** See [UIAlertViewDelegate willPresentAlertView:]. */
@property (copy, nonatomic)     IAAlertViewHandler      willPresentHandler;

/** See [UIAlertViewDelegate didPresentAlertView:]. */
@property (copy, nonatomic)     IAAlertViewHandler      didPresentHandler;

/** See [UIAlertViewDelegate alertView:willDismissWithButtonIndex:]. */
@property (copy, nonatomic)     IAAlertViewHandler      willDismissHandler;

/** See [UIAlertViewDelegate alertView:didDismissWithButtonIndex:]. */
@property (copy, nonatomic)     IAAlertViewHandler      didDismissHandler;


/**
 Returns the handler for the button at the given index.
 
 @param buttonIndex The index of the button. The button indices start at 0.
 @return The handler for the button specified by index buttonIndex.
 */
- (IAAlertViewHandler)handlerForButtonAtIndex:(NSInteger)buttonIndex;

/**
 Sets the handler for the button at the given index.
 
 @param handler The handler that will be called when the button is tapped.
 @param buttonIndex The index of the button. The button indices start at 0.
 */
- (void)setHandler:(IAAlertViewHandler)handler forButtonAtIndex:(NSInteger)buttonIndex;

@end

#pragma clang diagnostic pop
