/*
 * IRFormFieldCell.h
 *
 * This file defines the IRFormFieldCell base class. The IRFormFieldCell class
 * implements the basic behavior for all form field cells.
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
 * Base class for a cell that is used to present the value of a form field.
 *
 * The IRFormFieldCell class is the base class for a cell view that presents the
 * value of a form field and allows the user to edit or operate on the field.
 * The IRFormFieldCell class implements basic behavior or interfaces that are
 * overridden by derived classes or shared by derived classes.
 */
@interface IRFormFieldCell : UITableViewCell

/**
 * Makes the editable part of the cell view active.
 *
 * The activateCell method is called when the editable or interactive part of
 * the cell should become active. For example, in a cell with a text field, the
 * text field may become the first responder.
 *
 * The default implementation of this method does nothing.
 */
- (void)activateCell;

@end
