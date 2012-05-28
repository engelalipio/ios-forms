/*
 * UserProfile.h
 *
 * This file defines the UserProfile class. The UserProfile class models a user
 * and stores information that the user can enter on the sample form.
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

/**
 * Models the user's profile.
 *
 * The UserProfile class models a user and exposes properties for the user's
 * information. The properties of this object are bound to a data entry form
 * where the user can edit the information.
 */
@interface UserProfile : NSObject

/**
 * The user's annual gross income.
 *
 * The annualIncome property stores the user's annual income.
 */
@property (nonatomic, strong) NSNumber *annualIncome;

/**
 * The first name of the user.
 *
 * The firstName property stores the user's first name or given name.
 */
@property (nonatomic, copy) NSString *firstName;

/**
 * The last name of the user.
 *
 * The lastName property stores the user's last name or surname.
 */
@property (nonatomic, copy) NSString *lastName;

/**
 * The middle name of the user.
 *
 * The middleName property stores the user's middle name.
 */
@property (nonatomic, copy) NSString *middleName;

/**
 * The date in which the user will receive his next paycheck.
 *
 * The netPayDate property stores the date that the user will receive his next
 * paycheck.
 */
@property (nonatomic, strong) NSDate *nextPayDate;

/**
 * The prefix or title for the user's name.
 *
 * The prefix property stores a prefix or title for the user.
 */
@property (nonatomic, copy) NSString *prefix;

/**
 * The state where the user lives.
 *
 * The state property stores the abbreviation of the state where the user lives.
 */
@property (nonatomic, copy) NSString *state;

/**
 * The suffix for the user's name.
 *
 * The suffix property stores the suffix for the user's name if the user has
 * one.
 */
@property (nonatomic, copy) NSString *suffix;

@end
