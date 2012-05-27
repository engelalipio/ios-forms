/*
 * IRFormViewController+PrivateImplementation.h
 *
 * This file defines the PrivateImplementation category for the
 * IRFormViewController class. The methods defined in this category are used
 * internally to implement the IRFormViewController class and implement form
 * behavior and should not be invoked by consumers. This API is unstable and
 * may change.
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

@interface IRFormViewController (PrivateImplementation)

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
