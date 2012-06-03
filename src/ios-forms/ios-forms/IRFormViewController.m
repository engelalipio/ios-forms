/*
 * IRFormViewController.m
 *
 * This file implements the IRFormViewController class.
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

#import "IRFormViewController.h"
#import "IRForm.h"

@interface IRFormViewController ()

/** @name Notification Management */

/**
 * Registers an observer with the notification center for an event.
 *
 * The addObserver:selector:name:object method is used to register an observer
 * for a notification using the NSNotificationCenter class. This method is
 * implemented to support unit testing the notification management.
 *
 * @param notificationObserver The observer object.
 * @param aSelector A selector that will be invoked when the notification is
 *      received.
 * @param aName The name of the notification that will invoke the handler.
 * @param anObject This parameter is passed to the notification handler.
 */
- (void)addObserver:(id)notificationObserver
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject;

/**
 * Unregisters the observer with the notification center for all events.
 *
 * @param notificationObserver The observer object that will be unregistered
 *      from receiving notifications for all events.
 */
- (void)removeObserver:(id)notificationObserver;

/** @name Keyboard Handling */

/**
 * Resizes the form view when the keyboard appears.
 *
 * @param notification An NSNotification object containing information about the
 *      event.
 */
- (void)keyboardWillAppear:(NSNotification *)notification;

/**
 * Resizes the form view when the keyboard disappears.
 *
 * @param notification An NSNotification object containing information about the
 *      event.
 */
- (void)keyboardWillDisappear:(NSNotification *)notification;

@end

@implementation IRFormViewController

@synthesize tableView;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = [self.view frame];
    
    form = [self loadForm];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)
                                             style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    tableView.dataSource = form;
    tableView.delegate = form;
    
    [self addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [self addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [self removeObserver:self];
    
    self.tableView = nil;
    form = nil;
}

#pragma mark - 

- (IRForm *)loadForm {
    [self doesNotRecognizeSelector:@selector(loadForm)];
    return nil;
}

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
