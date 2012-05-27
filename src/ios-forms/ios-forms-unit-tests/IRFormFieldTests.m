/*
 * IRFormFieldTests.m
 *
 * This file implements the IRFormFieldTests class that unit tests the
 * IRFormField class.
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

#import "IRFormField.h"
#import "IRFormField+PrivateImplementation.h"

@interface IRFormFieldTests : GHTestCase
@end

@implementation IRFormFieldTests

- (void)testInitReturnsNilObject {
    IRFormField *field = [[IRFormField alloc] init];
    GHAssertNil(field, @"The field is not nil.");
}

- (void)testInitWithPropertyListSuccessfullyInitializesFormField {
    IRFormField *field = [[IRFormField alloc]
                          initWithPropertyList:@"TestField"
                          bundle:nil
                          model:[NSDictionary dictionary]];
    
    GHAssertNotNil(field, @"The field is nil.");
}

- (void)testValueReturnsPropertyValue {
    NSDictionary *model = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"Michael",
                           @"firstName",
                           nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"firstName",
                                @"KeyPath",
                                nil];
    
    IRFormField *field = [[IRFormField alloc] initWithDictionary:dictionary
                                                           model:model];
    GHAssertEqualStrings(@"Michael", [field value], @"The value of the field is incorrect.");
}

- (void)testSetValueSetsThePropertyValue {
    NSMutableDictionary *model = 
        [NSMutableDictionary dictionaryWithObjectsAndKeys:
         @"Ted",
         @"firstName",
         nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"firstName",
                                @"KeyPath",
                                nil];
    
    IRFormField *field = [[IRFormField alloc] initWithDictionary:dictionary
                                                           model:model];
    [field setValue:@"Michael"];
    
    GHAssertEquals(1U, [model count], @"The model does not have the property.");
    GHAssertEqualStrings(@"Michael", [model objectForKey:@"firstName"], @"The firstName property is not set.");
}

- (void)testCellForTableViewCreatesCell {
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    [[[mockTableView expect] andReturn:nil] dequeueReusableCellWithIdentifier:@"IRFormField"];
    
    NSMutableDictionary *model = [NSMutableDictionary dictionary];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"firstName", @"KeyPath", nil];
    IRFormField *field = [[IRFormField alloc] initWithDictionary:dictionary model:model];
    
    UITableViewCell *cell = [field cellForTableView:mockTableView];
    GHAssertNotNil(cell, @"The cell is nil.");
    GHAssertEquals(UITableViewCellSelectionStyleNone, cell.selectionStyle, @"The selection style is not none.");
    
    [mockTableView verify];
}

- (void)testCellForTableViewUsesReuseIdentifier {
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    [[[mockTableView expect] andReturn:nil] dequeueReusableCellWithIdentifier:@"TestField"];
    
    NSMutableDictionary *model = [NSMutableDictionary dictionary];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"firstName",
                                @"KeyPath",
                                @"TestField",
                                @"CellReuseIdentifier",
                                nil];
    IRFormField *field = [[IRFormField alloc] initWithDictionary:dictionary model:model];
    
    UITableViewCell *cell = [field cellForTableView:mockTableView];
    GHAssertNotNil(cell, @"The cell is nil.");
    GHAssertEqualStrings(@"TestField", cell.reuseIdentifier, @"The cell reuse identifier is incorrect.");
    
    [mockTableView verify];
}

- (void)testCellForTableViewRegistersCustomView {
    id mockCell = [OCMockObject mockForClass:[UITableViewCell class]];
    
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    [[mockTableView expect] registerNib:[OCMArg any] forCellReuseIdentifier:@"TestField"];
    [[[mockTableView expect] andReturn:mockCell] dequeueReusableCellWithIdentifier:@"TestField"];
    
    NSMutableDictionary *model = [NSMutableDictionary dictionary];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"firstName",
                                @"KeyPath",
                                @"TestField",
                                @"CellReuseIdentifier",
                                @"TestFieldCell",
                                @"CellNibName",
                                nil];
    IRFormField *field = [[IRFormField alloc] initWithDictionary:dictionary model:model];
    
    UITableViewCell *cell = [field cellForTableView:mockTableView];
    GHAssertNotNil(cell, @"The cell is nil.");
    
    [mockCell verify];
    [mockTableView verify];
}

- (void)testFormFieldLoadsiPadCellViewOniPadDevice {
    id mockCell = [OCMockObject mockForClass:[UITableViewCell class]];
    
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    [[mockTableView expect] registerNib:[OCMArg any] forCellReuseIdentifier:@"TestField_iPad"];
    [[[mockTableView expect] andReturn:mockCell] dequeueReusableCellWithIdentifier:@"TestField_iPad"];
    
    NSMutableDictionary *model = [NSMutableDictionary dictionary];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"firstName",
                                @"KeyPath",
                                @"TestField_iPad",
                                @"CellReuseIdentifier_iPad",
                                @"TestFieldCell",
                                @"CellNibName_iPad",
                                nil];
    IRFormField *field = [IRFormField alloc];
    id mockField = [OCMockObject partialMockForObject:field];    
    BOOL result = YES;
    [[[mockField expect] andReturnValue:OCMOCK_VALUE(result)] isiPad];
    
    id fieldResult = [mockField initWithDictionary:dictionary model:model];
    GHAssertEqualObjects(field, fieldResult, @"The result of initWithDictionary:model: is not the same field object.");
    
    UITableViewCell *cell = [mockField cellForTableView:mockTableView];
    GHAssertNotNil(cell, @"The cell is nil.");
    
    [mockField verify];
    [mockCell verify];
    [mockTableView verify];
}

- (void)testFormFieldLoadsiPhoneCellViewOniPhoneDevice {
    id mockCell = [OCMockObject mockForClass:[UITableViewCell class]];
    
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    [[mockTableView expect] registerNib:[OCMArg any] forCellReuseIdentifier:@"TestField_iPhone"];
    [[[mockTableView expect] andReturn:mockCell] dequeueReusableCellWithIdentifier:@"TestField_iPhone"];
    
    NSMutableDictionary *model = [NSMutableDictionary dictionary];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"firstName",
                                @"KeyPath",
                                @"TestField_iPhone",
                                @"CellReuseIdentifier_iPhone",
                                @"TestFieldCell",
                                @"CellNibName_iPhone",
                                nil];
    IRFormField *field = [IRFormField alloc];
    id mockField = [OCMockObject partialMockForObject:field];    
    BOOL result = NO;
    [[[mockField expect] andReturnValue:OCMOCK_VALUE(result)] isiPad];
    
    id fieldResult = [mockField initWithDictionary:dictionary model:model];
    GHAssertEqualObjects(field, fieldResult, @"The result of initWithDictionary:model: is not the same field object.");
    
    UITableViewCell *cell = [mockField cellForTableView:mockTableView];
    GHAssertNotNil(cell, @"The cell is nil.");
    
    [mockField verify];
    [mockCell verify];
    [mockTableView verify];
}

@end
