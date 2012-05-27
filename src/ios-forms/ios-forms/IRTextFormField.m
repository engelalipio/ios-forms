/*
 * IRTextFormField.h
 *
 * This file implements the IRTextFormField class.
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

#import "IRTextFormField.h"
#import "IRTextFormFieldCell.h"

@implementation IRTextFormField

#pragma mark - Initialization

- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)aModel {
    self = [super initWithDictionary:dictionary model:aModel];
    if (self) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            placeholder = [dictionary objectForKey:@"Placeholder_iPad"];
        } else {
            placeholder = [dictionary objectForKey:@"Placeholder_iPhone"];
        }

        if (!placeholder) {
            placeholder = [dictionary objectForKey:@"Placeholder"];
        }
    }
    
    return self;
}

#pragma mark - Cell creation and initialization

- (UITableViewCell *)createCellWithReuseIdentifier:(NSString *)reuseIdentifier {
    return [[IRTextFormFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView {
    UITableViewCell *cell = [super cellForTableView:tableView];
    
    UITextField *textField = (UITextField *)[cell.contentView viewWithTag:kIRFormFieldCellTextTag];
    textField.delegate = self;
    textField.placeholder = placeholder;
    textField.text = [self value];
    
    return cell;
}

#pragma mark - UITextFieldDelegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setValue:textField.text];
}

@end
