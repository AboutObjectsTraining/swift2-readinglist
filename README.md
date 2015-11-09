# Swift Reading List
**Cocoa touch (iOS) example written in Swift 2**

Version 1.0 *(requires Xcode 7)*

## Overview
An example app that demonstrates the following:

* Using Swift to target Cocoa touch C and Objective-C frameworks.
* Building and using an iOS 9 framework to share code and resources.
* Working with Key-Value Coding (KVC) APIs in Swift.

Illustrates the use of the Swift language in the implementation of fairly typical Cocoa touch application code. Includes use of the following features of Swift:

* Optionals
* Pattern matching
* Closures
* Extensions
* Swift collections
* Initializers
* Computed properties
* Functional programming with `map` and `reduce`

## Screenshots

![](Screenshots/reading-list.png)
<span style="width: 36px;">&nbsp;&nbsp;&nbsp;<span>
![](Screenshots/swiped-cell.png)
<span style="width: 36px;">&nbsp;&nbsp;&nbsp;<span>
![](Screenshots/action-sheet.png)
<span style="width: 36px;">&nbsp;&nbsp;&nbsp;<span>
![](Screenshots/book-detail.png)

## Targets

The project consists of the following Xcode targets:

* **ReadingListModel**

 Objective-C classes that model a reading list containing a list of books and authors, as well as an object store controller written in Swift that serializes and deserializes object graphs stored in plist format.

* **ReadingListModelTests**

 Unit tests written in Swift to exercise *ReadingListModel* Swift and Objective-C classes.

* **swift2-readinglist**

 Swift subclasses and extensions of UIKit classes. Storyboard-based. Depends on the *ReadingListModel* target.
 
---

Copyright &copy; 2015, [About Objects, Inc.](http://www.aboutobjects.com) All rights reserved. 