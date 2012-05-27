/*
 * IRFormTests.m
 *
 * This file implements the IRFormTests class that unit tests the IRForm class.
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
 
#import "IRForm.h"

@interface IRFormTests : GHTestCase
@end

@implementation IRFormTests

- (void)testNumberOfSectionsReturnsCorrectResult {
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    
    NSMutableDictionary *model = [NSMutableDictionary dictionary];
    
    IRForm *form = [[IRForm alloc] initWithPropertyList:@"TestForm" bundle:nil model:model];
    GHAssertNotNil(form, @"The form is nil.");
    
    GHAssertEquals(2,
                   [form numberOfSectionsInTableView:mockTableView],
                   @"The number of sections in the form is incorrect.");
    
    [mockTableView verify];
}

- (void)testNumberOfRowsInSectionReturnsCorrectResult {
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    
    NSMutableDictionary *model = [NSMutableDictionary dictionary];
    
    IRForm *form = [[IRForm alloc] initWithPropertyList:@"TestForm" bundle:nil model:model];
    GHAssertNotNil(form, @"The form is nil.");
    
    GHAssertEquals(3,
                   [form tableView:mockTableView numberOfRowsInSection:0],
                   @"The number of fields in incorrect.");
    
    [mockTableView verify];
}

- (void)testFormReturnsCellForField {
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    [[[mockTableView expect] andReturn:nil] dequeueReusableCellWithIdentifier:@"IRFormField"];
    
    NSMutableDictionary *model = [NSMutableDictionary dictionary];
    
    IRForm *form = [[IRForm alloc] initWithPropertyList:@"TestForm" bundle:nil model:model];
    GHAssertNotNil(form, @"The form is nil.");
    
    UITableViewCell *cell = [form tableView:mockTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    GHAssertNotNil(cell, @"The cell is nil.");
    
    [mockTableView verify];
}

@end
