---
layout: post
title: Getting Started with IRForms
description: IRForms is still a developing framework for building form-based applications for
  iOS devices, but it is very much usable today. In this post, I will guide you through creating
  your first application using the IRForms framework.
author: Michael F. Collins, III
disqus-identifier: ios-forms-2012-06-03-getting-started-with-irforms
---
Introduction
------------
I published the initial source code for the IRForms project last weekend, but
now I'm finally getting around to showing you how to use this framework. In
this post, I will guide you through adding the IRForms framework to your
project and creating your first form.

In this post, I will walk you through creating a demonstration application for
performing product registration for a purchased product. The application will
present several forms to allow the user to add information needed to register
the product. The demonstration application will be a universal application and
will support both the iPhone and iPad.

Getting Started
---------------
The first thing that you need to do in order to build a form-based application
is to download the IRForms framework from the
[Downloads](https://github.com/mfcollins3/ios-forms/downloads) page. Download
the current version of the framework. At the time of this writing, the current
version is the initial version (0.0.1-alpha.1). I am also using Xcode 4.3.2 to
build this application.

To demonstrate how to use this framework, I will create a new iOS application.
You can use an existing application if you have one or follow along with a new
application to experiment with the framework.

To begin, I created an empty application.

<figure>
    <img src="/ios-forms/images/2012-06-03/empty_application.png"/>
    <figcaption>Creating an empty application in Xcode</figcaption>
</figure>

Next, I added the **IRForms.framework** framework to my application by
right-clicking on the *Frameworks* node in Xcode and selecting the
*Add files to (project-name)* option on the context menu. If you are adding
the framework to an existing project, make sure that the correct targets are
selected for the IRForms framework to be added to.

The next step is to edit your project's prefix header file to import the main
header file for the IRForms project. You can add the following statement to
your prefix header:

{% highlight objc %}
#import <IRForms/IRForms.h>
{% endhighlight %}

Perform a test build to make sure that your project links correctly against
the framework.

Storyboards
-----------
iOS 5 and beyond is all about storyboard development. In this demonstration,
I will use the new storyboard feature to add forms to an application. The
IRForms framework does not depend on storyboards. You can continue to use it
with *the old way* of developing iOS applications. But I'm going to show you
the storyboard experience to show how to combine the two technologies.

The first step is to create the storyboards for the iPhone and iPad versions
of the application. The IRForms framework supports both devices, so you can use
the forms framework in a universal application. Initially, the storyboards will
be blank, but I will add my sample forms to these storyboards as I develop
them.

I created two empty storyboards: MainStoryboard_iPhone and
MainStoryboard_iPad. I next registered these two storyboards as the main
storyboards for the iPhone and iPad versions of the application. I next
modified the AppDelegate class to use storyboards for the user interface.

Creating the Model
------------------
The IRForms framework binds form elements to properties on a model object. The
model can be either an NSDictionary or a custom class. The only requirement is
that the model support key-value coding. In this demonstration, I will use a
custom model class.

In the IRForms framework, multiple forms can share the same model. Also, each
form can have a unique model. The important requirement is that the key paths
in the form definition are valid for the form's model.

In this demonstration, I created a single model that will be shared by all of
my forms. The source code for the **ProductRegistration** model class is
below:

{% highlight objc %}
/*
 * ProductRegistration.h
 *
 * This file defines the ProductRegistration model class. A ProductRegistration
 * object stores registration information for a product that was purchased by
 * the user.
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
 * Model class that stores the product registration information for the
 * purchased product.
 *
 * The ProductRegistration class exposes properties that store the information
 * about a product that the user purchased and wishes to register with the
 * company. The ProductRegistration object stores information about the
 * customer, the product that the user purchased, and where and when the user
 * purchased the product.
 */
@interface ProductRegistration : NSObject

/** @name Customer information */

/**
 * Gets or sets the name of the city where the user lives.
 *
 * The city property stores the name of the city where the user is located.
 */
@property (nonatomic, copy) NSString *city;

/**
 * Gets or sets the user's email address.
 *
 * The emailAddress property stores the email address where the company can send
 * emails with product announcements to the user.
 */
@property (nonatomic, copy) NSString *emailAddress;

/**
 * Gets or sets the user's first name.
 *
 * The firstName property stores the user's first or given name.
 */
@property (nonatomic, copy) NSString *firstName;

/**
 * Gets or sets the user's last name.
 *
 * The lastName property stores the user's last or surname.
 */
@property (nonatomic, copy) NSString *lastName;

/**
 * Gets or sets the postal code for the user's address.
 *
 * The postalCode property stores the postal code for the user's mailing
 * address.
 */
@property (nonatomic, copy) NSString *postalCode;

/**
 * Gets or sets the state where the user lives.
 *
 * The state property stores the abbreviation of the state where the user is
 * located.
 */
@property (nonatomic, copy) NSString *state;

/**
 * Gets or sets the user's street address.
 *
 * The streetAddress property stores the street address where the user lives.
 */
@property (nonatomic, copy) NSString *streetAddress;

/**
 * Gets or sets the user's Twitter account name.
 *
 * The twitterName property stores the user's name on Twitter.
 */
@property (nonatomic, copy) NSString *twitterName;

/** @name Product information */

/**
 * Gets or sets the title of the product that the user purchased.
 *
 * The productTitle property stores the title of the product that the user
 * purchased and is registering.
 */
@property (nonatomic, copy) NSString *productTitle;

/**
 * Gets or sets the serial number for the purchased product.
 *
 * The serialNumber property stores the serial number of the purchased product.
 */
@property (nonatomic, copy) NSString *serialNumber;

/** @name Purchase information */

/**
 * Gets or sets the date that the user purchased the product from the seller.
 *
 * The purchaseDate property stores the date that the user purchased the product
 * from the seller.
 */
@property (nonatomic, strong) NSDate *purchaseDate;

/**
 * Gets or sets the price that the user paid to the seller for the product.
 *
 * The purchasePrive property stores the amount of money that the user paid to
 * the seller in order to purchase the product from the seller.
 */
@property (nonatomic, strong) NSNumber *purchasePrice;

/**
 * Gets or sets the name of the seller.
 *
 * The seller property stores the name of the seller that the user purchased the
 * product from.
 */
@property (nonatomic, copy) NSString *seller;

@end
{% endhighlight %}

{% highlight objc %}
/*
 * ProductRegistration.m
 *
 * This file implements the ProductRegistration class.
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

#import "ProductRegistration.h"

@implementation ProductRegistration

@synthesize city;
@synthesize emailAddress;
@synthesize firstName;
@synthesize lastName;
@synthesize postalCode;
@synthesize productTitle;
@synthesize purchaseDate;
@synthesize purchasePrice;
@synthesize seller;
@synthesize serialNumber;
@synthesize state;
@synthesize streetAddress;
@synthesize twitterName;

@end
{% endhighlight %}

Creating the Forms
------------------
Forms are added to the user interface using view controllers, and I will show
you how to do that soon. But before we get to that, we need to define the
forms. My goal with the IRForms framework was to require as little code as
possible in order to display a form in an application. I also wanted to make it
easy to manage forms and to add or remove fields, or to re-order the fields as
the application evolves or the user experience changes. I also did not want to
make it difficult to change the type of editor used for a field, so that you
might start out using a simple text field, but later decide that a picker-based
user interface is better for a field like a state or country name.

In the IRForms framework, forms are data-based and are created using property
lists. I chose property lists because the form structures can be easily
represented and modeled using property lists. Also, property list editing is
built into Xcode, so I do not need to create a form editor tool and give you
something else that you need to install in order to build or edit forms.

For this demonstration, I will be creating three forms:

1. Customer information form
2. Product information form
3. Purchase information form

All three forms will be based on the same model that was presented in the
previous section.

To create the customer information form:

1. Create a new property list. I will name mine *CustomerInformationForm.plist*.
2. Make your property list look like this:

* Sections (Array)
    * Item 0 (Dictionary)
        * Header (String) = Customer Information
        * Fields (Array)
            * Item 0 (Dictionary)
                * KeyPath (String) = firstName
                * LabelText (String) = First Name
                * Placeholder (String) = First name
            * Item 1 (Dictionary)
                * KeyPath (String) = lastName
                * LabelText (String) = Last Name
                * Placeholder (String) = Last name
            * Item 3 (Dictionary)
                * KeyPath (String) = city
                * LabelText (String) = City
                * Placeholder (String) = City
            * Item 4 (Dictionary)
                * Type (String) = Picker
                * KeyPath (String) = state
                * LabelText (String) = State
                * Placeholder (String) = State
                * Values (Dictionary)
                    * Alabama (String) = AL
                    * Alaska (String) = AK
                    * Arizona (String) = AZ
                    * Arkansas (String) = AR
                    * California (String) = CA
                    * Colorado (String) = CO
                    * Connecticut (String) = CT
                    * Delaware (String) = DE
                    * District of Colombia (String) = DC
                    * Florida (String) = FL
                    * Georgia (String) = GA
                    * Hawaii (String) = HI
                    * Idaho (String) = ID
                    * Illinois (String) = IL
                    * Indiana (String) = IN
                    * Iowa (String) = IA
                    * Kansas (String) = KS
                    * Kentucky (String) = KY
                    * Louisiana (String) = LA
                    * Maine (String) = ME
                    * Maryland (String) = MD
                    * Massachusetts (String) = MA
                    * Michigan (String) = MI
                    * Minnesota (String) = MN
                    * Mississippi (String) = MS
                    * Missouri (String) = MO
                    * Montana (String) = MT
                    * Nebraska (String) = NE
                    * Nevada (String) = NV
                    * New Hampshire (String) = NH
                    * New Jersey (String) = NJ
                    * New Mexico (String) = NM
                    * New York (String) = NY
                    * North Carolina (String) = NC
                    * North Dakota (String) = ND
                    * Ohio (String) = OH
                    * Oklahoma (String) = OK
                    * Oregon (String) = OR
                    * Pennsylvania (String) = PA
                    * Rhode Island (String) = RI
                    * South Carolina (String) = SC
                    * South Dakota (String) = SD
                    * Tennessee (String) = TN
                    * Texas (String) = TX
                    * Utah (String) = UT
                    * Vermont (String) = VT
                    * Virginia (String) = VA
                    * Washington (String) = WA
                    * West Virginia (String) = WV
                    * Wisconsin (String) = WI
                    * Wyoming (String) = WY
            * Item 5 (Dictionary)
                * KeyPath (String) = postalCode
                * LabelText (String) = Postal Code
                * Placeholder (String) = Postal code
                * KeyboardType (String) = NumberPad
    * Item 1 (Dictionary)
        * Header (String) = Contact Information
        * Fields (Array)
            * Item 0 (Dictionary)
                * KeyPath (String) = emailAddress
                * LabelText (String) = Email
                * Placeholder (String) = Email address
                * KeyboardType (String) = EmailAddress
            * Item 1 (Dictionary)
                * KeyPath (String) = twitterName
                * LabelText (String) = Twitter
                * Placeholder (String) = Twitter name
                * KeyboardType (String) = Twitter

The customer information form modeled above has two sections. The first section
collects the user's first and last name, and the user's mailing address. The
second section collects the user's email address and twitter name.

Take a look at the form definition. The majority of the fields in the form use
a simple text field. Text fields are so common that they are the default field.
If you want to use a field type other than text, you can specify the type of
input control to use for each field using the "Type" item. In the current
version of the framework, the following types are supported:

* Text
* Number
* Date
* Picker

More types will be added in the future. The number and date types have further
subtypes that control the input or formatting for the value. For example, the
Currency subtype of the Number type will format the value in the form as a
currency when the field is not in edit mode.

The second form definition for product information should look like this:

* Sections (Array)
    * Item 0 (Dictionary)
        * Header (String) = Product Information
        * Fields (Array)
            * Item 0 (Dictionary)
                * KeyPath (String) = productTitle
                * LabelText (String) = Product Title
                * Placeholder (String) = Product title
            * Item 1 (Dictionary)
                * KeyPath (String) = serialNumber
                * LabelText (String) = Serial Number
                * Placeholder (String) = Serial number

The third form definition for the purchase information form should look like
this:

* Sections (Array)
    * Item 0 (Dictionary)
        * Header (String) = Purchase information
        * Fields (Array)
            * Item 0 (Dictionary)
                * Type (String) = Picker
                * KeyPath = seller
                * LabelText (String) = Seller
                * Placeholder (String) = Seller
                * Values (Dictionary)
                    * Best Buy (String) = Best Buy
                    * Apple Store (String) = Apple Store
                    * Web Store (String) = Web Store
                    * Other (String) = Other
            * Item 1 (Dictionary)
                * Type (String) = Date
                * DateStyle (String) = Long
                * KeyPath (String) = purchaseDate
                * LabelText (String) = Purchase Date
                * Placeholder (String) = Purchase date
            * Item 2 (Dictionary)
                * Type (String) = Number
                * Style (String) = Currency
                * KeyPath (String) = purchasePrice
                * LabelText (String) = Purchase Price
                * Placeholder (String) = Purchase price

The purchase information form demonstrates how to use the Number and Date form
field types. With the Number form field, we are using the Currency style or
subtype to indicate that when the value is not being edited, the form field
should present the value formatted as a currency value. For the Date form
field, we are indicating that the long date format should be used. Because we
have not specified a style for time, the user will only be allowed to edit the
date.

Creating the View Controllers
-----------------------------
In order to add the forms to our user interface, you need to define one view
controller for each form. The view controllers will be pretty bare for now, but
in the future you will be able to add more form logic and event handling to
your view controller. At the present time, however, we will only add code to
the view controllers to load the form to be displayed in the view.

In the IRForms framework, view controllers are derived from the
*IRFormViewController* class. The IRFormViewController class displays the form
in a *UITableView* object. The IRFormViewController class also receives
notification when the input view is going to appear or disappear.
IRFormViewController class will resize the table view object when the input
view shows or hides in order to allow the full form to be accessible regardless
of whether the input view is visible or not.

Before we can create any view controllers, we need to create the model. In this
demonstration, I am going to store the model object in the *AppDelegate* class:

{% highlight objc %}
/*
 * AppDelegate.h
 *
 * This file defines the AppDelegate class. An AppDelegate object is used as the
 * delegate for the UIApplication object that runs the application. The
 * AppDelegate object manages the global application state and responds to
 * application lifecycle events.
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

@class ProductRegistration;

/**
 * Application delegate for the IRForms demonstration application.
 *
 * The AppDelegate class implements the delegate for the UIApplication object
 * that runs the IRForms demonstration application. The AppDelegate object
 * manages the application and responds to lifecycle events. The AppDelegate
 * object will also manage the global application state.
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>

/**
 * Gets the model that stores the product registration information.
 *
 * The model property exposes the ProductRegistration object that stores the
 * information for the product registration. The model object is bound to the
 * forms that the user edits to add his product registration and personal
 * information.
 */
@property (strong, nonatomic, readonly) ProductRegistration *model;

/**
 * Gets or sets the main window for the application.
 *
 * The window property stores a reference to the window that presents the
 * user interface for the IRForms demonstration application.
 */
@property (strong, nonatomic) UIWindow *window;

@end
{% endhighlight %}

{% highlight objc %}
/*
 * AppDelegate.m
 *
 * This file implements the AppDelegate class.
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

#import "AppDelegate.h"
#import "ProductRegistration.h"

@implementation AppDelegate

@synthesize model;
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    model = [[ProductRegistration alloc] init];
    return YES;
}

@end
{% endhighlight %}

When I create the view controllers for the forms, there is only one method that
I need to implement: **loadForm**. The loadForm method is called by the view
controller when the form needs to be loaded. It is the responsibility of the
loadForm method to create or obtain the model object, and then load the form
definition using an initializer on the **IRForm** class. Below is the source
code for the **CustomerInformationFormViewController** class that demonstrates
how to load the customer information form:

{% highlight objc %}
/*
 * CustomerInformationFormViewController.h
 *
 * This file defines the CustomerInformationFormViewController class. The
 * CustomerInformationFormViewController class manages the presentation of the
 * customer information form to the user.
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
 * View controller that presents a form for the user to enter information about
 * himself.
 */
@interface CustomerInformationFormViewController : IRFormViewController
@end
{% endhighlight %}

{% highlight objc %}
/*
 * CustomerInformationFormViewController.m
 *
 * This file implements the CustomerInformationFormViewController class.
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

#import "CustomerInformationFormViewController.h"
#import "AppDelegate.h"

@implementation CustomerInformationFormViewController

- (IRForm *)loadForm {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [[IRForm alloc] initWithPropertyList:@"CustomerInformationForm"
                                         bundle:nil
                                          model:appDelegate.model];
}

@end
{% endhighlight %}

The form as it should appear to you is below:

<figure>
    <img src="/ios-forms/images/2012-06-03/customer_information_form.png"/>
    <figcaption>Customer information form on an iPhone</figcaption>
</figure>

The *ProductInformationFormViewController* and
*PurchaseInformationFormViewController* classes are similar. Once all of the
classes were created, I added the view controllers to my storyboard embedded
inside of a navigation controller and wired the *Next* buttons to navigate to
the next form in the chain:

<figure>
    <img src="/ios-forms/images/2012-06-03/storyboard.png"/>
    <figcaption>Storyboard for the forms</figcaption>
</figure>

The product information and purchase information forms are shown below:

<figure>
    <img src="/ios-forms/images/2012-06-03/product_information_form.png"/>
    <figcaption>Product information form on an iPhone</figcaption>
</figure>

<figure>
    <img src="/ios-forms/images/2012-06-03/purchase_information_form.png"/>
    <figcaption>Purchase information form on an iPhone</figcaption>
</figure>

Conclusion
----------
In this post, I gave you a quick introduction on how to use the IRForms
framework to create a simple form-based user interface with three forms that
were bound to the same model. I demonstrated all of the currently supported
editor types. I also showed you how to create property lists containing form
definitions and use view controllers to load the forms. I hope that you see
the value in this framework and will begin to incorporate it into your own
projects.