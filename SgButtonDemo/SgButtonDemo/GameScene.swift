//
//  GameScene.swift
//  SgButtonDemo
//
//  Created by Nguyen Pham on 22/3/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var buttonSheet = Buttons()

    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.gray
        
        let x: CGFloat = 100
        var y: CGFloat = self.frame.height - 160
        
        /*
        * Using image file
        */
        // Simplest
        let btn00 = SgButton(normalImageNamed: "back.png", buttonFunc: tappedButton)
        btn00.position = CGPointMake(x, y)
        btn00.tag = 0
        self.addChild(btn00)
        

        // 3 images for 3 states, rotate
        let btn01 = SgButton(normalImageNamed: "back.png", highlightedImageNamed: "back_d.png", disabledImageNamed: "back_x.png",
                             clickSoundName: "click", buttonFunc: tappedButton)
        btn01.position = CGPointMake(x + 100, y)
        btn01.tag = 1
        btn01.zRotation = CGFloat(Float.pi / 2)
        self.addChild(btn01)
        

        // 3 images for 3 states
        y -= 80
        let btn10 = SgButton(normalImageNamed: "back.png", highlightedImageNamed: "back_d.png", disabledImageNamed: "back_x.png", buttonFunc: tappedButton)
        btn10.position = CGPointMake(x, y)
        btn10.tag = 10
        self.addChild(btn10)

        // 3 images for 3 states, start by highlighted state
        let btn11 = SgButton(normalImageNamed: "back.png", highlightedImageNamed: "back_d.png", disabledImageNamed: "back_x.png", buttonFunc: tappedButton)
        btn11.position = CGPointMake(x + 100, y)
        btn11.state = .highlighted
        btn11.tag = 11
        self.addChild(btn11)
        
        // 3 images for 3 states, disabled
        let btn12 = SgButton(normalImageNamed: "back.png", highlightedImageNamed: "back_d.png", disabledImageNamed: "back_x.png", buttonFunc: tappedButton)
        btn12.position = CGPointMake(x + 200, y)
        btn12.disabled = true
        btn12.tag = 13
        self.addChild(btn12)
        
        /*
         * Using texture from sprite sheet
         */
        
        y -= 80
        let btn20 = SgButton(normalTexture: buttonSheet.buy(), highlightedTexture: buttonSheet.buy_d(), clickSoundName: "click", buttonFunc: tappedButton)
        btn20.position = CGPointMake(x, y)
        btn20.tag = 20
        self.addChild(btn20)
        
        // the second texture for highlighted is bigger than the first one, but button is still same size
        let btn21 = SgButton(normalTexture: buttonSheet.buy(), highlightedTexture: buttonSheet.back(), clickSoundName: "click", buttonFunc: tappedButton)
        btn21.position = CGPointMake(x + 100, y)
        btn21.tag = 21
        self.addChild(btn21)
        
        // using closure as the button func, change texture randomly after tapping
        let btn22 = SgButton(normalTexture: buttonSheet.buy(), highlightedTexture: buttonSheet.back(), clickSoundName: "click", buttonFunc: { (button: SgButton) -> Void in
            let names: [ String ] = [ self.buttonSheet.BUY, self.buttonSheet.BUY_D, self.buttonSheet.BACK, self.buttonSheet.BACK_D, self.buttonSheet.BACK_X ]
            let k = Int(arc4random() % UInt32(names.count))
            let str = names[k]
            let newTex = self.buttonSheet.textureAtlas.textureNamed(str)
            button.setTexture(state: .normal, texture: newTex)
        })
        btn22.position = CGPointMake(x + 200, y)
        btn22.tag = 22
        self.addChild(btn22)
        
        /*
         *   Using text and background as plan color
         */
        
        // Simplest case. The button created with black text, white background, size is just fit to the text
        y -= 80
        let btn30 = SgButton(normalString: "Hello World!!!", clickSoundName: "click", buttonFunc: tappedButton)
        btn30.position = CGPointMake(x, y)
        btn30.tag = 30
        self.addChild(btn30)

        // Round corner button
        let btn31 = SgButton(normalString: "Tap me",
                             normalStringColor: UIColor.blue,
                             normalBackgroundColor: UIColor.yellow, fontName: "Arial", fontSize: 25,
                             size: CGSizeMake(200, 40),
                             cornerRadius: 10.0,
                             buttonFunc: tappedButton)

        btn31.setString(state: .highlighted, string: "Being tapped", stringColor: UIColor.red, backgroundColor: UIColor.green)
        btn31.position = CGPointMake(x + 200, y)
        btn31.tag = 31
        self.addChild(btn31)
        
        /*
        *   Using text & image as background
        */
        y -= 90
        let btn40 = SgButton(normalImageNamed: "bkbtn.png", buttonFunc: tappedButton)
        btn40.setString(state: .normal, string: "REGISTER", stringColor: UIColor.blue)
        btn40.setString(state: .highlighted, string: "REGISTER", stringColor: UIColor.red)
        btn40.position = CGPointMake(x, y)
        btn40.tag = 40
        self.addChild(btn40)
        
        let btn41 = SgButton(normalImageNamed: "bkbtn.png", buttonFunc: tappedButton)
        btn41.setString(state: .normal, string: "Fun", stringColor: UIColor.blue)
        btn41.setString(state: .highlighted, string: "Funiest", stringColor: UIColor.red)
        btn41.position = CGPointMake(x + 200, y)
        btn41.zRotation = CGFloat(Float.pi / 4)
        btn41.tag = 40
        self.addChild(btn41)
        
        
        /*
        *   Using text & texture as background
        * WARRNING: in the case of combining text and texture, due to the current limit of the technique (convert texture to image),
        * all black point of the texture will be converted into transparent. Avoid to use black details in the texture if you don not
        * want that effect
        */
        y -= 90
        let btn50 = SgButton(normalTexture: buttonSheet.greenbutton(), highlightedTexture: buttonSheet.yellowbutton(), buttonFunc: tappedButton)
        btn50.setString(state: .normal, string: "Are you sure?", fontSize: 24, stringColor: UIColor.white)
        btn50.setString(state: .highlighted, string: "LOL!!!", stringColor: UIColor.blue)
        btn50.position = CGPointMake(x, y)
        btn50.tag = 50
        self.addChild(btn50)
    }
    
    func tappedButton(button: SgButton) {
        print("tappedButton tappedButton tag=\(button.tag)")
    }
}
