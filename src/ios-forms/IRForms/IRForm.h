/*
 * IRForm.h
 *
 * This file defines the IRForm class. The IRForm class represents a data entry
 * form and controls the form user interface.
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
#import "IRFormDelegate.h"

/**
 * The IRForm class represents a data entry form.
 *
 * The IRForm class manages all of the information for a data entry form and
 * works with an IRFormViewController object to present the form and the data
 * entry user interface to the user. The IRForm class acts as both a table view
 * delegate and data source and works with the table view user interface that
 * is presented by the IRFormViewController in order to present the sections
 * and fields of the form correctly.
 */
@interface IRForm : NSObject <UITableViewDataSource, UITableViewDelegate, IRFormFieldDelegate> {
    @private
    NSMutableArray *sections;
    NSIndexPath *activeField;
}

/** @name Properties */

/**
 * Gets or sets the delegate for the form.
 *
 * The delegate property stores a reference to an object that implements the
 * IRFormDelegate protocol. The IRForm object will invoke the delegate methods
 * on the delegate to inform the delegate of events that affect the state or
 * presentation of the form.
 */
@property (nonatomic, weak) id<IRFormDelegate> delegate;

/** @name Initializing an IRForm Instance */

/**
 * Initializes an IRForm instance using settings in a dictionary.
 *
 * The initWithDictionary:model: method is the designated initializer for the
 * IRForm class. The initWithDictionary:model method will load the form from an
 * NSDictionary object.
 *
 * @param dictionary An NSDictionary object containing the settings for the
 *      form.
 * @param model The model that stores the state for the form.
 * @return Returns the initialized IRForm object, or nil if an error occurred.
 */
- (id)initWithDictionary:(NSDictionary *)dictionary model:(id)model;

/**
 * Initializes an IRForm instance using settings stored in a property list.
 *
 * The initWithPropertyList:bundle:model: method will load a form from a
 * property list.
 *
 * @param propertyListName The name of the property list that contains the form
 *      definition.
 * @param bundle The bundle that contains the property list, or nil to use the
 *      main bundle for the application.
 * @param model The model that stores the state for the form.
 * @return Returns the initialized IRForm object, or nil if an error occurred.
 */
- (id)initWithPropertyList:(NSString *)propertyListName
                    bundle:(NSBundle *)bundle 
                     model:(id)model;

/** @name Scrolling */

/**
 * Scrolls to the active field in the table view.
 *
 * @param tableView The UITableView object that is presenting the form user
 *      interface.
 */
- (void)scrollToActiveFieldInTableView:(UITableView *)tableView;

@end
