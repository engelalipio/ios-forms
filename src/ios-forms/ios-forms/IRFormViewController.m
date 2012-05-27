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
#import "IRFormViewController+PrivateImplementation.h"
#import "IRForm.h"

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

@end
