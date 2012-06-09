/*
 * IRFormViewController.h
 *
 * This file defines the IRFormViewController class. The IRFormViewController
 * class implements a view controller that presents a form-based user interface
 * to the user for data entry.
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

/**
 * View controller for a data entry form.
 *
 * The IRFormViewController class implements a view that presents a data entry
 * user experience to the user. The IRFormViewController class embeds a
 * UITableView object that presents the data entry form as a table view. The
 * table view is linked to an IRForm object that implements the form and manages
 * the data entry experience.
 */
@interface IRFormViewController : UIViewController <IRFormDelegate> {
    @private
    IRForm *form;
}

/** @name Properties */

@property (nonatomic, strong) UITableView *tableView;

/** @name Must Be Overridden by Derived Classes */

/**
 * Creates or loads the form to be presented in the view.
 *
 * This method must be overridden by a derived class in order to load the form
 * that the view will present to the user.
 *
 * @return Returns an IRForm object containing the definition of the form to be
 *      presented in the view.
 */
- (IRForm *)loadForm;

@end
