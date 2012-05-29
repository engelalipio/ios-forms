---
layout: post
title: Introduction to iOS Forms
description: In this post, I will introduce you to the iOS Forms project and
    show you how to use the library to build form-based user experiences for
    your iOS applications.
disqus_identifier: ios-forms-2012-05-28-introduction-to-ios-forms
author: Michael F. Collins, III
---
I have written several iOS applications over the past three years that I have
been doing iOS development. Some of these applications were for internal
customer demonstrations. Others are out in the
[Apple App Store](http://itunes.apple.com/us/app/crs-temporary-housing/id485358023?mt=8).
One theme that has been pretty constant in the applications that I have been
creating data entry forms for business applications. In this post, I will
introduce you to a new library framework that I have created and open sources
in order to help make it easier for others to build standard data entry
applications for iPhone and iPad devices.

Creating form-based user interfaces on the iPhone or iPad usually take the
shape of two kinds of user interfaces:

1. Custom form built using Interface Builder
2. Table-based user interface with custom cells

The problem with using custom forms built in Interface Builder is that as the
forms evolve and change, it becomes a pain to maintain and manage these forms.
When using Interface Builder, it is also difficult to build forms that are
larger than the visible area of the screen. When writing applications that are
targeting the iPad as well as the iPhone, you are also then required to build
the iPad version of the form which may differ significantly from the iPhone
version given the additional screen area available on the iPad.

Using UITableView as the basis of a form-based user interface is better, but
it can still be problematic. The common problem with this approach is that
everyone implements customized solutions that are different. When you develop
multiple data entry applications, or multiple forms, it becomes time consuming
to continually build custom form-based user interfaces. Each table-based form
also requires the use of custom cells with text boxes and labels to enable ata
entry. Along with text boxes and custom cells, there is the delegate and event
handling that needs to be implemented to make the editing experience seem
natural and set the underlying data model from the values entered into the
data entry form.

When I started building the early versions of this project for my first data
entry user interfaces, my focus was first learning how to best build a form
user experience that makes data entry easy and natural. I also looked to what
should be "standard" on iOS devices. Prior to iOS 3.2, most form interfaces
were combined with UINavigationController objects and in order to edit a field
you would touch the field in the table and the table would navigate to a
specialized view for editing the value of the single field. iOS 3.2 introduced
the inputView property to the UITextField class that allows applications to
replace the standard keyboard with custom views at the bottom of the screen.

The input views, whether standard or custom keyboards, also introduces a new
problem that form user interfaces need to handle. When the input view appears
on the screen, the form user interface needs to resize the form view so that
while the user is editing the form, the user can scroll to see the complete
contents of the form without having the bottom of the form cut off and obscured
by the input view.

The intent of the iOS Forms project is to make it easier and faster for
developers to build form-based user experiences that employ best practices for
data entry on iOS devices. The iOS Forms framework is intended to require the
least amount of code necessary to implement a form. In order to accomplish
this, the iOS Forms project uses data-driven property lists that are defined
using standard property lists. The forms also binds fields directly to
properties on a model object or an NSDictionary object using key-value coding.

In future posts, I will walk you through the current features of the iOS Forms
framework and I will show you how to start using this framework in your own
applications to build form user interfaces.

Before I wrap this post, I have a couple of points to share:

1. This project is open source and is licensed under the MIT License (see the
   [License](/ios-forms/license.html) page for the specific details).
2. You may use this project in both your open source or commercial projects.
3. Please feel free to fork and build upon this framework. If you have new
   features or bug fixes that you want to include in the "official" framework,
   please feel free to send me a pull request. I will happily review all pull
   requests and put ample consideration in all pull requests.
4. I am trying to build the best user experience that I can with this
   framework. The concepts used in this framework have been used in successful
   applications that have been approved by Apple and included in the App Store.
   I have no indication right now that using this library for your own user
   interfaces will cause any issues with App Store submission. However, if any
   significant issues arise, I will diligently work to fix the issues.

Finally, I am very happy to learn from others. If you have additional or
alternative techniques, please feel free to share them with me. I would love to
receive insights, opinions, and advice from others.

I hope that you find this framework to be valuable to your own projects and
hopefully it makes developing form-based user experiences easier for you.