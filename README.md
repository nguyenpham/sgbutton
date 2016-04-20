SgButton in Swift for SpriteKit
===============================

Background
----------

When starting working with SpriteKit, we have found that that framework has not supported buttons yet. Some current open-source is not good enough for me. Thus I have created this component to fill my needs. The code is written in Swift. We share it in hope it may be usefull to others as well as having more contributes / improvements from other programmers.

Screenshots
-------
![Simple selector](https://github.com/nguyenpham/sgbutton/blob/master/etc/image1.png?raw=true)


Features
-------
* Create buttons from image files or texture (sprite sheet)
* Create rectangle / round corner rectangle buttons
* Create buttons with string (text)
* Work well with defferent screen (rentina)
* Work well after being rotated, changed anchorPoint

Installation
-------

### Add files directly

Copy the file SgButton.swift (in the SgButton folder) into your project.


### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate SgButton into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'sgbutton'
```

Then, run the following command:

```bash
$ pod install
```

Usage
-----
Use image files to create buttons:

        var btn1 = SgButton(normalImageNamed: "back.png")
        var btn2 = SgButton(normalImageNamed: "back.png", highlightedImageNamed: "back_d.png", disabledImageNamed: "back_x.png", buttonFunc: tappedButton)

Use textures (from spritesheet) to create buttons:

        var btn3 = SgButton(normalTexture: buttonSheet.buy(), highlightedTexture: buttonSheet.buy_d(), buttonFunc: tappedButton)

Create text buttons (round corner button):

        var btn4 = SgButton(normalString: "Tap me", normalStringColor: UIColor.blueColor(), size: CGSizeMake(200, 40), cornerRadius: 10.0, buttonFunc: tappedButton)

Create text buttons with image as background

        var btn5 = SgButton(normalTexture: buttonSheet.greenbutton(), highlightedTexture: buttonSheet.yellowbutton(), buttonFunc: tappedButton)
        btn5.setString(.Normal, string: "Are you sure?", fontSize: 24, stringColor: UIColor.whiteColor())

License
-------
[Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)
