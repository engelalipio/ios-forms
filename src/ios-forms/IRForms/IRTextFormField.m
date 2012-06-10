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
    if (!self) {
        return self;
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        placeholder = [dictionary objectForKey:@"Placeholder_iPad"];
    } else {
        placeholder = [dictionary objectForKey:@"Placeholder_iPhone"];
    }
    
    if (!placeholder) {
        placeholder = [dictionary objectForKey:@"Placeholder"];
    }

    NSString *value = [dictionary objectForKey:@"AutocapitalizationType"];
    autocapitalizationType = UITextAutocapitalizationTypeNone;
    if (value) {
        value = [value lowercaseString];
        if ([value isEqualToString:@"all"]) {
            autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        } else if ([value isEqualToString:@"sentences"]) {
            autocapitalizationType = UITextAutocapitalizationTypeSentences;
        } else if ([value isEqualToString:@"words"]) {
            autocapitalizationType = UITextAutocapitalizationTypeWords;
        }
    }
    
    NSNumber *numberValue = [dictionary objectForKey:@"AutocorrectionType"];
    autocorrectionType = UITextAutocorrectionTypeDefault;
    if (numberValue) {
        autocorrectionType = [numberValue boolValue] ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo;
    }
    
    value = [dictionary objectForKey:@"KeyboardAppearance"];
    keyboardAppearance = UIKeyboardAppearanceDefault;
    if ([[value lowercaseString] isEqualToString:@"alert"]) {
        keyboardAppearance = UIKeyboardAppearanceAlert;
    }
    
    value = [dictionary objectForKey:@"KeyboardType"];
    keyboardType = UIKeyboardTypeDefault;
    if (value) {
        value = [value lowercaseString];
        if ([value isEqualToString:@"ascii"]) {
            keyboardType = UIKeyboardTypeASCIICapable;
        } else if ([value isEqualToString:@"numbersandpunctuation"]) {
            keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        } else if ([value isEqualToString:@"url"]) {
            keyboardType = UIKeyboardTypeURL;
        } else if ([value isEqualToString:@"numberpad"]) {
            keyboardType = UIKeyboardTypeNumberPad;
        } else if ([value isEqualToString:@"phonepad"]) {
            keyboardType = UIKeyboardTypePhonePad;
        } else if ([value isEqualToString:@"namephonepad"]) {
            keyboardType = UIKeyboardTypeNamePhonePad;
        } else if ([value isEqualToString:@"emailaddress"]) {
            keyboardType = UIKeyboardTypeEmailAddress;
        } else if ([value isEqualToString:@"decimalpad"]) {
            keyboardType = UIKeyboardTypeDecimalPad;
        } else if ([value isEqualToString:@"twitter"]) {
            keyboardType = UIKeyboardTypeTwitter;
        } else if ([value isEqualToString:@"alphabet"]) {
            keyboardType = UIKeyboardTypeAlphabet;
        }
    }
    
    numberValue = [dictionary objectForKey:@"EnablesReturnKeyAutomatically"];
    enablesReturnKeyAutomatically = numberValue ? [numberValue boolValue] : NO;
    
    value = [dictionary objectForKey:@"ReturnKeyType"];
    returnKeyType = UIReturnKeyDefault;
    if (value) {
        value = [value lowercaseString];
        if ([value isEqualToString:@"go"]) {
            returnKeyType = UIReturnKeyGo;
        } else if ([value isEqualToString:@"google"]) {
            returnKeyType = UIReturnKeyGoogle;
        } else if ([value isEqualToString:@"join"]) {
            returnKeyType = UIReturnKeyJoin;
        } else if ([value isEqualToString:@"next"]) {
            returnKeyType = UIReturnKeyNext;
        } else if ([value isEqualToString:@"route"]) {
            returnKeyType = UIReturnKeyRoute;
        } else if ([value isEqualToString:@"search"]) {
            returnKeyType = UIReturnKeySearch;
        } else if ([value isEqualToString:@"send"]) {
            returnKeyType = UIReturnKeySend;
        } else if ([value isEqualToString:@"yahoo"]) {
            returnKeyType = UIReturnKeyYahoo;
        } else if ([value isEqualToString:@"done"]) {
            returnKeyType = UIReturnKeyDone;
        } else if ([value isEqualToString:@"emergencycall"]) {
            returnKeyType = UIReturnKeyEmergencyCall;
        }
    }
    
    numberValue = [dictionary objectForKey:@"Secure"];
    secureTextEntry = numberValue ? [numberValue boolValue] : NO;
    
    numberValue = [dictionary objectForKey:@"SpellChecking"];
    spellCheckingType = UITextSpellCheckingTypeDefault;
    if (numberValue) {
        spellCheckingType = [numberValue boolValue] ? UITextSpellCheckingTypeYes : UITextSpellCheckingTypeNo;
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
    textField.text = [self displayValue];
    textField.autocapitalizationType = autocapitalizationType;
    textField.autocorrectionType = autocorrectionType;
    textField.keyboardAppearance = keyboardAppearance;
    textField.keyboardType = keyboardType;
    textField.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically;
    textField.returnKeyType = returnKeyType;
    textField.secureTextEntry = secureTextEntry;
    textField.spellCheckingType = spellCheckingType;
    textField.inputView = [self createInputView];
    if (placeholder) {
        textField.placeholder = NSLocalizedString(placeholder, nil);
    }
    
    return cell;
}

#pragma mark - UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    cellTextField = textField;
    textField.text = [self editValue];
    [self.delegate formFieldDidBecomeActive:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id actualValue = [self valueForText:textField.text];
    [self setValue:actualValue];
    textField.text = [self displayValue];
    cellTextField = nil;
}

- (NSString *)displayValue {
    return [self value];
}

- (NSString *)editValue {
    return [self value];
}

- (id)valueForText:(NSString *)text {
    return text;
}

- (void)updateText {
    if (!cellTextField) {
        return;
    }
    
    cellTextField.text = [self editValue];
}

- (UIView *)createInputView {
    return nil;
}

- (NSString *)defaultCellReuseIdentifier {
    return @"IRTextFormField";
}

@end
