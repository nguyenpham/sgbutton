SgButton in Swift for SpriteKit
===============================
Update March 2023
-----------------
- Support Swift 5
- Support sounds, new button type


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
* Sound click
* Work well with defferent screen (rentina)
* Work well after being rotated, changed anchorPoint

Installation
-------

### Add files directly

Copy the file SgButton.swift (in the SgButton folder) into your project.


Usage
-----
Use image files to create buttons:

        var btn1 = SgButton(normalImageNamed: "back.png")
        var btn2 = SgButton(normalImageNamed: "back.png", highlightedImageNamed: "back_d.png", disabledImageNamed: "back_x.png", buttonFunc: tappedButton)

Use textures (from spritesheet) to create buttons:

        var btn3 = SgButton(normalTexture: buttonSheet.buy(), highlightedTexture: buttonSheet.buy_d(), buttonFunc: tappedButton)

Create text buttons (round corner button):

        var btn4 = SgButton(normalString: "Tap me", normalStringColor: UIColor.blue, size: CGSizeMake(200, 40), cornerRadius: 10.0, buttonFunc: tappedButton)

Users can setup for highlighed and disabled state too. Just any of parametters will be fine:

        var btn44 = SgButton(normalString: "Tap me", normalStringColor: UIColor.blue, highlightedStringColor: UIColor.yellow,  size: CGSizeMake(200, 40), cornerRadius: 10.0, buttonFunc: tappedButton)

Create text buttons with image as background

        var btn5 = SgButton(normalTexture: buttonSheet.greenbutton(), highlightedTexture: buttonSheet.yellowbutton(), buttonFunc: tappedButton)
        btn5.setString(.Normal, string: "Are you sure?", fontSize: 24, stringColor: UIColor.white)

License
-------
[Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)
Almost total free, just fair use!
