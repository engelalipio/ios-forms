/*
 * IRFormSection.h
 *
 * This file implements the IRFormSection class. The IRFormSection class
 * represents a section of a form and manages the fields in the section.
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
 * The IRFormSection class represents a section of a data entry form.
 *
 * An IRFormSection object stores one or more fields that are presented to the
 * user as a section of a form. A section may have a title and descriptive text
 * as well as the fields.
 */
@interface IRFormSection : NSObject

/** @name Initializing an IRFormSection instance. */

/**
 * Initializes the IRFormSection object using the settings in a dictionary.
 *
 * The initWithDictionary:model: method is the designated initializer for the
 * IRFormSection class. The initWithDictionary:model: method will load the
 * section and the section's fields from the dictionary.
 *
 * @param dictionary An NSDictionary object containing the settings for the
 *      section and form fields.
 * @param model The model that stores the state for the form.
 * @return Returns the IRFormSection object, or nil if an error occurred.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)model;

/**
 * Initializes the IRFormSection object from a property list.
 *
 * The initWithPropertyList:bundle:model: method will read a property list and
 * will initialize the form section and form fields from the settings that are
 * stored in the property list.
 *
 * @param propertyListName The name of the property list that stores the form
 *      section's settings.
 * @param bundle The bundle that contains the property list, or nil to use the
 *      application bundle.
 * @param model The model that stores the state for the form.
 * @return Returns the IRFormSection object, or nil if an error occurred.
 */
- (id)initWithPropertyList:(NSString *)propertyListName
                    bundle:(NSBundle *)bundle
                     model:(id)model;

@end
