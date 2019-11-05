# Long-press context menu

<img align="left" src="https://github.com/ekamalov/MediaFiles/blob/master/LongPress.gif" width="480" height="360"/>

### About
The mobile screen has a more confined space than desktop. Have to be careful with the design layout of application interfaces, to create ergonomically right decisions. In some cases, we have multi-action buttons without a primary action. Putting all buttons to interface or hiding to a modal view can be wrong behavior for some solutions. We have designed the long-press context menu, which is called up by a long pressing on the screen of the mobile. Design on [Dribble](https://dribbble.com/shots/7970503-Long-press-context-menu-Concept?utm_source=Clipboard_Shot&utm_campaign=ehrlan&utm_content=Long-press%20context%20menu%20(Concept)&utm_medium=Social_Share)
###### If you 👍 the project, do not forget ⭐️ me <br> Stay tuned for the latest updates [Follow me](https://github.com/ekamalov) 🤙
<br>

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/ekamalov/EKLongPress/issues)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Version](https://img.shields.io/github/release/ekamalov/EKLongPress.svg)](https://github.com/ekamalov/EKLongPress/releases)
[![CocoaPods](http://img.shields.io/cocoapods/v/EKLongPress.svg)](https://cocoapods.org/pods/EKLongPress)
[![Build Status](https://travis-ci.org/ekamalov/EKLongPress.svg?branch=master)](https://travis-ci.org/ekamalov/EKLongPress)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/EKLongPress.svg?style=flat)](http://cocoapods.org/pods/EKLongPress)

## Requirements

- iOS 12.2+
- Xcode 11+
- Swift 5.0+

## Features
Included in this repository there are 2 layouts, further will be added others:
- [x] Fully customizable
- [x] Auto calculable intersection
- [ ] More [contributing](#Contributing) are very welcome 🙌

## Example
First clone the repo, and run `carthage update` from the root directory.
The example application is the best way to see `EKLongPress` in action. Simply open the `EKLongPress.xcodeproj` and run the `Example` scheme.

## Installation

### CocoaPods

EKLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'EKLongPress'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

To integrate `EKLongPress` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ruby
github "ekamalov/EKLongPress"
```

Run `carthage update` to build the framework and drag the built `EKLongPress.framework` into your Xcode project.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase” and add the Framework path as mentioned in [Carthage Getting started Step 4, 5 and 6](https://github.com/Carthage/Carthage/blob/master/README.md#if-youre-building-for-ios-tvos-or-watchos)

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate `EKLongPress` into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

After installing the lib and importing the module `EKLongPress`, the text field can be used like any other text field.
`ContextMenu` initializer
```swift
    /// - Parameter items: Items
    /// - Parameter aling: To position relative to the ability to specify alignment. The items can be layouted relative to one or many comparable views.
    /// - Parameter preference: Preference used to customize the appearance
    /// - Parameter selectedItem: Close if selected item
    /// - Parameter debug: For developer
    public init(items: [EKItem], aling:ItemsAling = .center, preference: Preference = .init(),
    selectedItem: ((_ item:EKItem) -> Void)? , debug:Bool = false) {
    }

```
Initializer EKItem

```swift
    /// - Parameter title: Title of the item
    /// - Parameter icon: Icon of the iten
    /// - Parameter preference: Item appearance
    public init(title: String, icon: UIImage, preference: Preference.ContextMenu.Item) {
    }
 ```
 Using
 ```swift
/// Example
// First needed to create an array of type EKItem you desire to show.
// For each item, you can create your appearance setting
let items: [EKItem] = [ EKItem.init(title:"Save", icon: #imageLiteral(resourceName: "add")),
                        EKItem.init(title:"Watch Trailer", icon: #imageLiteral(resourceName: "play")),
                        EKItem.init(title:"Share", icon: #imageLiteral(resourceName: "share")),
                        EKItem.init(title:"More", icon: #imageLiteral(resourceName: "more"))]

var cons = EKContextMenu(items: items, aling: .center, selectedItem: nil, debug: false)
view.addGestureRecognizer(cons.buildGesture()) // to add gesture call buildGesture method
 ```

If you want to change the appearance look `Customizing` heading or below👇. use setAppearance method

```swift
let items: [EKItem] = [ EKItem.init(title:"Save", icon: #imageLiteral(resourceName: "add")),
                        EKItem.init(title:"Watch Trailer", icon: #imageLiteral(resourceName: "play")),
                        EKItem.init(title:"Share", icon: #imageLiteral(resourceName: "share")),
                        EKItem.init(title:"More", icon: #imageLiteral(resourceName: "more"))]

var cons = EKContextMenu(items: items, aling: .center, selectedItem: nil, debug: false)

var preference = Preference.init()
preference.menu.titleFont = Fonts.GilroyBold.withSize(48)
cons.setAppearance(preference: preference)

view.addGestureRecognizer(cons.buildGesture()) // to add gesture call buildGesture method
```

## Customizing

In order to customize the `EKLongPress` appearance and behavior, you can play with the `Preferences` structure which encapsulates all the customizable properties. These preferences have been split into three structures:

<p align="center"> <img src="https://i.imgur.com/saZ1TM2.png" width="500" height="300"></p>

### Basic
encapsulates customizable properties specifying how `EKLongPress` will be drawn on the screen. See the default values:

```swift
/// Use the backgroundColor property to change the color of the context menu backgroundColor. By default, uses white with alpha 0.9
public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.9)

/// Use the itemsDistance property to change the distance of the items between. By default, uses 15px
public var itemsDistance:CGFloat = 15

/// Use the itemDistFromCenter property to change the distance from of the item to touch point. By default, uses 15px
public var itemDistFromCenter:CGFloat = 34

/// Use the titleFont property to change the font of the  title font. By default user "Gilroy-SemiBold"  with size 48
public var titleFont:UIFont = .systemFont(ofSize: 48)

/// Use the titleColor property to change the color of the title text. By default, uses white with alpha 0.9
public var titleColor:UIColor = .white

/// Use the titleDistance property to change the distance from of the item to title text. By default, uses 64px
public var titleDistance:CGFloat = 64

/// Use the marginOfScreen property to change tThe indent from the edge of the screen. By default, uses 20px
public var marginOfScreen:CGFloat = 20
```

#### TouchPoint
You can format `TouchPoint` with your own parameters. Use this to get your desired style. See the default values:

```swift
/// Use the color property to change the color of the touch point. By default, uses white with alpha 0.1
public var color: UIColor = UIColor.white.withAlphaComponent(0.1)

/// The size of the touch location view // default 44
public var size: CGFloat = 44

/// The size of the touch location view // default value 6
public var borderWidth:CGFloat = 6
```
#### Item
Use this to get your desired style.. See the default values:

```swift
/// Use the backgroundColor property to change the color of the item background. By default, uses white with alpha 0.1
public var backgroundColor:ColotState = .init(active: .white,
                                              inactive: .init(red: 28 / 255, green: 28 / 255, blue: 28 / 255, alpha: 1))

/// Use the iconColor property to change the color of the icon color. By default, uses white with alpha 0.1
public var iconColor:ColotState = .init(active: .black, inactive: .white)

/// Use the iconSize property to change the size of the icon. By default, user width: 24, height: 24
public var iconSize:CGSize = .init(width: 24, height: 24)

/// Use the size property to change the size of the item. By default, user 56
public var size: CGFloat = 56
```
## Contributing
Contributions are very welcome 🙌

## License
`EKLongPress`  is released under the MIT license. Check LICENSE.md for details.

```
  MIT License

  Copyright (c) 2019 Erik Kamalov <ekamalov967@gmail.com>

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
```
