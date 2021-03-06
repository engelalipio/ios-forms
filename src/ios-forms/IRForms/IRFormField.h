/*
 * IRFormField.h
 *
 * This file defines the IRFormField class. The IRFormField class is the base
 * class for fields that are displayed for entering data into a form.
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

#import "IRFormFieldDelegate.h"

/**
 * Base class for a form field.
 *
 * The IRFormField class implements the base class for a form field. Subclasses
 * will add specific behavior for the type of field being used to represent
 * data to be edited.
 */
@interface IRFormField : NSObject {
    @private
    id model;
    NSString *keyPath;
    NSString *cellReuseIdentifier;
    NSString *cellNibName;
    NSString *cellBundleId;
    BOOL cellNibRegistered;
}

/** @name Properties */

/**
 * Gets or sets the delegate that receives notifications of events from the form
 * field.
 *
 * The delegate property stores a reference to an object that implements the
 * IRFormFieldDelegate protocol. The delegate object will receive notifications
 * of events that affect the state of the form field.
 */
@property (nonatomic, weak) id<IRFormFieldDelegate> delegate;

/**
 * Gets or sets the index path of the form field in the presentation table.
 *
 * The indexPath property stores the index path of the field when presented in
 * a form table view.
 */
@property (nonatomic, copy) NSIndexPath *indexPath;

/** @name Initializing an IRFormField Instance */

/**
 * Initializes a new IRFormField instance from the settings in a dictionary.
 *
 * The initWithDictionary: method is the designated initializer for the
 * IRFormField class.
 *
 * @param dictionary An NSDictionary object containing the settings to apply to
 *      the form field.
 * @param aModel The model object that contains the value for the form field.
 * @return Returns the initialized object, or nil if an error occurred while
 *      initializing the object.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)aModel;

/**
 * Initializes a new IRFormField by loading the field definition from a property
 * list.
 *
 * @param propertyListName The name of the property list containing the field
 *      definition
 * @param bundle The bundle containing the property list, or nil if the property
 *      list is in the application bundle.
 * @param aModel The model object that contains the value for the form field.
 * @return Returns the initialized object, or nil if an error occurred while
 *      initializing the object.
 */
- (id)initWithPropertyList:(NSString *)propertyListName
                    bundle:(NSBundle *)bundle
                     model:(id)aModel;

/** @name Field Value */

/**
 * Gets the value of the property that the form field is mapped to.
 *
 * @return Returns the value of the property that the form field is mapped to.
 */
- (id)value;

/**
 * Sets the value of the property that the form field is mapped to.
 *
 * @param value The new value for the property backing the form field.
 */
- (void)setValue:(id)value;

/** @name Create the View for the Field */

/**
 * Creates the cell view for the form field.
 *
 * The cellForTableView: method is overridden by derived classes to create and
 * initialize a UITableViewCell object that contains the user experience for the
 * form field.
 *
 * @param tableView The UITableView object that the form field is creating the
 *      cell user interface for.
 * @return Returns a UITableViewCell object that will present the field's user
 *      experience to the user in the form's table view.
 */
- (UITableViewCell *)cellForTableView:(UITableView *)tableView;

/**
 * Creates the cell view for the form field.
 *
 * The cellForTableView: method will invoke createCellWithReuseIdentifier: to
 * create a new cell object. Subclasses will override this method to return the 
 * correct cell. If the form field specifies a custom cell in a nib resource, 
 * this method will not be called.
 *
 * @param reuseIdentifier The reuse identifier to use for the custom table cell.
 * @return Returns the UITableViewCell object.
 */
- (UITableViewCell *)createCellWithReuseIdentifier:(NSString *)reuseIdentifier;

/** @name Default settings */

/**
 * Gets the default cell reuse identifier for the field type.
 *
 * This method can be overridden by derived classes to return a different cell
 * reuse identifier specific to the field type.
 *
 * @return Returns the default cell reuse identifier to use for the field type.
 */
- (NSString *)defaultCellReuseIdentifier;

@end
