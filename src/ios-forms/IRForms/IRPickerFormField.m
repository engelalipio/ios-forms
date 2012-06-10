/*
 * IRPickerFormField.m
 *
 * This file implements the IRPickerFormField class.
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

#import "IRPickerFormField.h"

@interface IRPickerItem : NSObject

@property (nonatomic, readonly) NSString *key;
@property (nonatomic, readonly) id value;

- (id)initWithKey:(NSString *)aKey value:(id)aValue;

@end

@implementation IRPickerFormField

- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)aModel {
    self = [super initWithDictionary:dictionary model:aModel];
    if (!self) {
        return self;
    }
    
    NSDictionary *valuesSource = [dictionary objectForKey:@"Values"];
    NSMutableArray *tempValues = [NSMutableArray arrayWithCapacity:[valuesSource count]];
    for (NSString *key in [valuesSource allKeys]) {
        id value = [valuesSource objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            value = NSLocalizedString(value, nil);
        }
        
        IRPickerItem *pickerItem = [[IRPickerItem alloc] initWithKey:NSLocalizedString(key, nil) value:value];
        [tempValues addObject:pickerItem];
    }

    [tempValues sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 key] compare:[obj2 key]];
    }];
    values = [NSArray arrayWithArray:tempValues];
    
    return self;
}

- (UIView *)createInputView {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    id currentValue = [self value];
    if (currentValue) {
        NSUInteger index = [values indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            IRPickerItem *item = obj;
            return [currentValue isEqual:item.value];
        }];
        if (index != NSNotFound) {
            selectedItem = [values objectAtIndex:index];
            [pickerView selectRow:index inComponent:0 animated:NO];
        }
    }
    
    return pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [values count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    selectedItem = [values objectAtIndex:row];
    [self setValue:selectedItem.value];
    [self updateText];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    IRPickerItem *item = [values objectAtIndex:row];
    return item.key;
}

- (NSString *)displayValue {
    return selectedItem ? selectedItem.key : nil;
}

- (NSString *)editValue {
    return [self displayValue];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [super textFieldDidBeginEditing:textField];
    
    if (!selectedItem) {
        selectedItem = [values objectAtIndex:0];
        [self setValue:selectedItem.value];
        [self updateText];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    selectedItem = nil;
    [self setValue:nil];
    [self updateText];
    return YES;
}

- (NSString *)defaultCellReuseIdentifier {
    return @"IRPickerFormField";
}

@end

@implementation IRPickerItem

@synthesize key;
@synthesize value;

- (id)initWithKey:(NSString *)aKey value:(id)aValue {
    self = [super init];
    if (self) {
        key = aKey;
        value = aValue;
    }
    
    return self;
}

@end
