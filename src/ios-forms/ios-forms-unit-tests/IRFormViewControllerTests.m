/*
 * IRFormViewControllerTests.m
 *
 * This file implements the IRFormViewControllerTests class that unit tests the
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

#import "IRFormViewController.h"
#import "IRFormViewController+PrivateImplementation.h"
#import "IRForm.h"

@interface IRFormViewControllerTests : GHTestCase
@end

@implementation IRFormViewControllerTests

- (void)testViewDidLoadInitializesViewController {
    IRFormViewController *viewController = [[IRFormViewController alloc] init];
    id mockViewController = [OCMockObject partialMockForObject:viewController];
    
    [[mockViewController expect] addObserver:viewController selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[mockViewController expect] addObserver:viewController selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    id mockView = [OCMockObject mockForClass:[UIView class]];
    CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    [[[mockView stub] andReturnValue:OCMOCK_VALUE(frame)] frame];
    [[[mockViewController stub] andReturn:mockView] view];
    
    [[mockView expect] addSubview:[OCMArg any]];
    
    id mockForm = [OCMockObject mockForClass:[IRForm class]];
    [[[mockViewController expect] andReturn:mockForm] loadForm];
    
    [mockViewController viewDidLoad];
    
    [mockView verify];
    [mockViewController verify];
    [mockForm verify];
}

- (void)testViewDidUnloadRemovesNotifications {
    IRFormViewController *viewController = [[IRFormViewController alloc] init];
    id mockViewController = [OCMockObject partialMockForObject:viewController];
    
    [[mockViewController expect] removeObserver:viewController];
    
    [mockViewController viewDidUnload];
    
    [mockViewController verify];
}

@end
