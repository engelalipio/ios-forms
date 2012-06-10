/*
 * IRDateFormField.m
 *
 * This file implements the IRDateFormField class.
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

#import "IRDateFormField.h"

@interface IRDateFormField ()

- (void)dateChanged:(id)sender;

@end

@implementation IRDateFormField

- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)aModel {
    self = [super initWithDictionary:dictionary model:aModel];
    if (!self) {
        return self;
    }

    NSString *value = [dictionary objectForKey:@"DateStyle"];
    dateStyle = NSDateFormatterNoStyle;
    if (value) {
        value = [value lowercaseString];
        if ([value isEqualToString:@"short"]) {
            dateStyle = NSDateFormatterShortStyle;
        } else if ([value isEqualToString:@"medium"]) {
            dateStyle = NSDateFormatterMediumStyle;
        } else if ([value isEqualToString:@"long"]) {
            dateStyle = NSDateFormatterLongStyle;
        } else if ([value isEqualToString:@"full"]) {
            dateStyle = NSDateFormatterFullStyle;
        }
    }
    
    value = [dictionary objectForKey:@"TimeStyle"];
    timeStyle = NSDateFormatterNoStyle;
    if (value) {
        value = [value lowercaseString];
        if ([value isEqualToString:@"short"]) {
            timeStyle = NSDateFormatterShortStyle;
        } else if ([value isEqualToString:@"medium"]) {
            timeStyle = NSDateFormatterMediumStyle;
        } else if ([value isEqualToString:@"long"]) {
            dateStyle = NSDateFormatterLongStyle;
        } else if ([value isEqualToString:@"full"]) {
            dateStyle = NSDateFormatterFullStyle;
        }
    }
    
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [super textFieldDidBeginEditing:textField];
    
    if (![self value]) {
        [self setValue:[NSDate date]];
        [self updateText];
    }
}

- (NSString *)displayValue {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:dateStyle];
    [formatter setTimeStyle:timeStyle];
    return [formatter stringFromDate:[self value]];
}

- (NSString *)editValue {
    return [self displayValue];
}

- (id)valueForText:(NSString *)text {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:dateStyle];
    [formatter setTimeStyle:timeStyle];
    return [formatter dateFromString:text];
}

- (void)dateChanged:(id)sender {
    UIDatePicker *datePicker = sender;
    [self setValue:datePicker.date];
    [self updateText];
}

- (UIView *)createInputView {
    UIDatePickerMode mode;
    if (dateStyle != NSDateFormatterNoStyle && timeStyle != NSDateFormatterNoStyle) {
        mode = UIDatePickerModeDateAndTime;
    } else if (dateStyle != NSDateFormatterNoStyle) {
        mode = UIDatePickerModeDate;
    } else if (timeStyle != NSDateFormatterNoStyle) {
        mode = UIDatePickerModeTime;
    }
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.datePickerMode = mode;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    return datePicker;
}

- (NSString *)defaultCellReuseIdentifier {
    return @"IRDateFormField";
}

@end
