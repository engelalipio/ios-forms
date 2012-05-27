/*
 * IRFormViewController+PrivateImplementation.m
 *
 * This file implements the PrivateImplementation category for the
 * IRFormViewController class.
 *
 * Copyright 2012 ImaginaryRealities, LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILIY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMANGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#import "IRFormViewController+PrivateImplementation.h"

@implementation IRFormViewController (PrivateImplementation)

#pragma mark - Notification Management

- (void)addObserver:(id)notificationObserver selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] addObserver:notificationObserver selector:aSelector name:aName object:anObject];
}

- (void)removeObserver:(id)notificationObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:notificationObserver];
}

#pragma mark - Keyboard notification methods

- (CGRect)adjustFrameHeightBy:(CGFloat)change multipliedBy:(NSInteger)direction
{
    CGRect frame = self.view.frame;
    CGFloat newHeight = 1 == direction ? frame.size.height : frame.size.height - change;
    return CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, newHeight);
}

- (CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}

- (void)matchAnimationTo:(NSDictionary *)userInfo
{
    [UIView setAnimationDuration:[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
}

- (void)keyboardWillAppear:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:NULL];
    [self matchAnimationTo:[notification userInfo]];
    self.tableView.frame = [self adjustFrameHeightBy:[self keyboardEndingFrameHeight:[notification userInfo]] multipliedBy:-1];
    [UIView commitAnimations];
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:NULL];
    [self matchAnimationTo:[notification userInfo]];
    self.tableView.frame = [self adjustFrameHeightBy:[self keyboardEndingFrameHeight:[notification userInfo]] multipliedBy:1];
    [UIView commitAnimations];
}

@end
