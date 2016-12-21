//
//  SgButton.swift
//
//  Created by Nguyen Pham on 10/02/2015.
//  Copyright (c) 2015 TonyPham. All rights reserved.
//

import SpriteKit

class SgButton: SKSpriteNode {
    enum ButtonState {
        case normal, highlighted, disabled
    }
    
    fileprivate class Record {
        /* Input image */
        var imageFileName: String?
        var imageTexture: SKTexture?
        
        /* text */
        var string: String?
        var fontName: String?
        var fontSize: CGFloat?
        var stringColor: UIColor?
        
        /* Background color */
        var backgroundColor: UIColor?
        var cornerRadius: CGFloat?
        
        /* Size */
        var buttonSize: CGSize?
        
        var generatedImageTexture: SKTexture?
        
        func getFont() -> UIFont {
            let fSz: CGFloat = fontSize == nil ? 18 : fontSize!
            var font: UIFont
            if fontName != nil {
                let f = UIFont(name: fontName!, size: fSz)
                assert(f != nil, "Error: Cannot create font \(fontName) / \(fontSize)")
                font = f!
            } else {
                font = UIFont.systemFont(ofSize: fSz)
            }
            return font
        }
        
        func getImageWithColor(_ color: UIColor, size: CGSize, cornerRadius: CGFloat?) -> UIImage {
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            color.setFill()
            
            if cornerRadius != nil {
                UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius!).addClip()
            }
            
            UIRectFill(rect)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
        
        fileprivate func getImage(_ tex: SKTexture) -> UIImage? {
            let sz = tex.size()
            
            UIGraphicsBeginImageContextWithOptions(sz, false, 0.0);
            _ = UIGraphicsGetCurrentContext();
            
            let rect = CGRect(x: 0, y: 0, width: sz.width, height: sz.height)
            let view = SKView(frame:rect)
            let scene = SKScene(size: sz)
            view.backgroundColor = UIColor.clear
            
            /*
             * WARNING: Limited technique. When converting a texture into image, all transparent points will be lost
             * My currrent solution: fill all transparent points by black ones, those black points will be converted
             * back into transparent later. Thus texture for background button (only in case using with string) should 
             * not have black points to avoid that limit
             */
            scene.backgroundColor = UIColor.black    // -> color will be converted into transparent
            let sprite  = SKSpriteNode(texture: tex)
            sprite.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
            
            scene.addChild(sprite)
            view.presentScene(scene)
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            
            //Create the image from the context
            let image = UIGraphicsGetImageFromCurrentImageContext();
            
            //Close the context
            UIGraphicsEndImageContext();
            
            return image
        }
        
        /*
         * WARNING: to avoid blending effect, we convert all black points with value from 0 to 50 into transprent
         */
        //RGB color range to mask (make transparent)  R-Low, R-High, G-Low, G-High, B-Low, B-High
        fileprivate let colorMasking:[CGFloat] = [0, 50, 0, 50, 0, 50]

        fileprivate func makeTransparent(_ image: UIImage?) -> UIImage? {
            if image == nil {
                return nil
            }
            let img = UIImage(data:  UIImageJPEGRepresentation(image!, 1.0)! )
            let imageRef = img!.cgImage?.copy(maskingColorComponents: colorMasking);
            return UIImage(cgImage: imageRef!, scale: image!.scale, orientation: UIImageOrientation.up)
        }

        
        fileprivate var textAttributes: [String: AnyObject]?
        fileprivate var stringSz: CGSize?
        
        func generateTexture() -> Bool {
            
            if string != nil {
                let color = stringColor == nil ? UIColor.black : stringColor!
                textAttributes = [
                    NSForegroundColorAttributeName: color,
                    NSFontAttributeName: getFont()
                ]
                stringSz = string!.size(attributes: textAttributes)
            }

            
            if imageFileName != nil || (imageTexture==nil && string != nil) {
                var image: UIImage?
                
                if imageFileName != nil {
                    image = UIImage(named: imageFileName!)
                } else {
                    let sz: CGSize = buttonSize != nil ? buttonSize! : stringSz!
                    let color: UIColor = backgroundColor ?? UIColor.white
                    image = getImageWithColor(color, size: sz, cornerRadius: cornerRadius)
                }
                
                if string==nil {
                    generatedImageTexture = SKTexture(image: image!)
                } else {
                    generatedImageTexture = generatedString(image, string: string!, font: getFont())
                }
                return true
            }
            
            if imageTexture != nil {
                if string==nil {
                    generatedImageTexture = imageTexture
                } else {
                    /*
                     * Due to the limit of current technique to convert a texture into image (cannot keep transparence)
                     * we have to convert later all back points into transparent ones. Don not use black in the background
                     * button images if you dont want them to be transparent in case of having string
                     */
                    let image = makeTransparent(getImage(imageTexture!))
                    if image == nil {
                        return false
                    }
                    generatedImageTexture = generatedString(image, string: string!, font: getFont())
                }
                return true
            }
            
            return false
        }
        
        func generatedString(_ image: UIImage?=nil, string: String, font: UIFont) -> SKTexture {
            var sz: CGSize
            
            if buttonSize != nil {
                sz = buttonSize!
            } else if image != nil {
                sz = image!.size
            } else {
                sz = stringSz!
            }

            UIGraphicsBeginImageContextWithOptions(sz, false, 0.0);
            let ctx = UIGraphicsGetCurrentContext();
            
            if image != nil {
                image!.draw(at: CGPoint.zero)
            } else {
                let color = backgroundColor ?? UIColor.white
                color.setFill()
                ctx?.fill(CGRect(x: 0, y: 0, width: sz.width, height: sz.height));
            }
            
            let rect = sz==stringSz! ?  CGRect(x: 0, y: 0, width: sz.width, height: sz.height) : CGRect(x: (sz.width - stringSz!.width) * 0.5, y: (sz.height - stringSz!.height) * 0.5, width: stringSz!.width, height: stringSz!.height)
            (string as NSString).draw(in: rect, withAttributes: textAttributes)
            
            //Create the image from the context
            let image = UIGraphicsGetImageFromCurrentImageContext();
            
            //Close the context
            UIGraphicsEndImageContext();
            
            return SKTexture(image: image!)
        }
    }
    
    /*
     * Assign to name for convernient debug / work
     */
    let buttonName = "SgButton"
    
    /*
     * Convernient tag
     */
    var tag: Int = 0
    
    
    /*
    * Function to be called after being tapped
    */
    var buttonFunc: ((_ button: SgButton) -> Void)?
    
    /*
    * Internal data, should not be accessed from outside
    */
    
    fileprivate var records = [ ButtonState : Record]()
    
    fileprivate var isDisabled: Bool = false
    fileprivate var _buttonState  = ButtonState.normal
    fileprivate var _size: CGSize?
    
    /*
    * Init
    */
    init(normalImageNamed: String, highlightedImageNamed: String? = nil, disabledImageNamed: String? = nil, size: CGSize? = nil, buttonFunc: ((_ button: SgButton) -> Void)? = nil) {
        let record = Record()
        record.imageFileName = normalImageNamed
        _ = record.generateTexture()
        
        self.buttonFunc = buttonFunc
        
        super.init(texture: record.generatedImageTexture, color: UIColor.clear, size: record.generatedImageTexture!.size())

        records[ .normal ] = record
        
        if highlightedImageNamed != nil {
            let record = Record()
            record.imageFileName = highlightedImageNamed
            _ = record.generateTexture()
            records[ .highlighted ] = record
        }
        
        if disabledImageNamed != nil {
            let record = Record()
            record.imageFileName = disabledImageNamed
            _ = record.generateTexture()
            records[ .disabled ] = record
        }
        
        completeInit()
    }
    
    init(normalTexture: SKTexture, highlightedTexture: SKTexture? = nil, disabledTexture: SKTexture? = nil, buttonFunc: ((_ button: SgButton) -> Void)? = nil) {
        let record = Record()
        record.imageTexture = normalTexture
        _ = record.generateTexture()

        self.buttonFunc = buttonFunc
        
        super.init(texture: record.generatedImageTexture, color: UIColor.clear, size: record.generatedImageTexture!.size())

        records[ .normal ] = record
        
        if highlightedTexture != nil {
            let record = Record()
            record.imageTexture = highlightedTexture
            _ = record.generateTexture()
            records[ .highlighted ] = record
        }
        
        if disabledTexture != nil {
            let record = Record()
            record.imageTexture = disabledTexture
            _ = record.generateTexture()
            records[ .disabled ] = record
        }
        
        completeInit()
    }

    init(normalString: String, normalFontName: String? = nil, normalFontSize: CGFloat? = nil, normalStringColor: UIColor? = nil, backgroundNormalColor: UIColor? = nil, size: CGSize? = nil, cornerRadius: CGFloat? = nil, buttonFunc: ((_ button: SgButton) -> Void)? = nil) {
        let record = Record()
        record.string = normalString
        record.stringColor = normalStringColor
        record.fontName = normalFontName
        record.fontSize = normalFontSize
        record.backgroundColor = backgroundNormalColor
        record.buttonSize = size
        record.cornerRadius = cornerRadius
        _ = record.generateTexture()
        
        self.buttonFunc = buttonFunc
        
        super.init(texture: record.generatedImageTexture, color: UIColor.clear, size: record.generatedImageTexture!.size())
        
        records[ .normal ] = record
        
        _size = size
        
        completeInit()
    }
    
    /*
    * Methods
    */
    var disabled: Bool {
        set {
            isDisabled = newValue
            buttonState = isDisabled ? .disabled : .normal
        }
        
        get {
            return self.isDisabled
        }
    }
    
    var buttonState: ButtonState {
        get {
            return self._buttonState
        }
        
        set {
            _buttonState = newValue
            if let tex = records[newValue]?.generatedImageTexture {
                self.texture = tex
            }
        }
    }
    

    func setString(_ state: ButtonState, string: String, fontName: String? = nil, fontSize: CGFloat? = nil, stringColor: UIColor? = nil, backgroundColor: UIColor? = nil, size: CGSize? = nil, cornerRadius: CGFloat? = nil) {
        var record = records[ state ]
        if record == nil {
            record = Record()
            records[ state ] = record
        }
        record!.string = string
        
        /*
         * copy data from normal state if current is nil
         */
        record!.fontName = fontName != nil ? fontName : records[ .normal ]?.fontName
        record!.fontSize = fontSize != nil ? fontSize : records[ .normal ]?.fontSize
        record!.stringColor = stringColor != nil ? stringColor : records[ .normal ]?.stringColor
        record!.backgroundColor = backgroundColor != nil ? backgroundColor : records[ .normal ]?.backgroundColor
        record!.buttonSize = size != nil ? size : records[ .normal ]?.buttonSize
        record!.cornerRadius = cornerRadius != nil ? cornerRadius : records[ .normal ]?.cornerRadius

        /*
         * copy background from normal state if current one is not enough info
         */
        if backgroundColor == nil && state != .normal && record!.imageFileName == nil && record!.imageTexture == nil {
            record!.imageFileName = records[ .normal ]?.imageFileName
            record!.imageTexture = records[ .normal ]?.imageTexture
        }

        _ = record!.generateTexture()
        
        // update current texture
        if buttonState == state {
            buttonState = state
        }
    }
    
    func setImage(_ state: ButtonState, imageFileName: String) {
        var record = records[ state ]
        if record == nil {
            record = Record()
            records[ state ] = record
        }
        
        record!.imageFileName = imageFileName

        _ = record!.generateTexture()
        
        // update current texture
        if buttonState == state {
            buttonState = state
        }
    }

    func setTexture(_ state: ButtonState, texture: SKTexture) {
        var record = records[ state ]
        if record == nil {
            record = Record()
            records[ state ] = record
        }
        
        record!.imageTexture = texture
        
        _ = record!.generateTexture()
        
        // update current texture
        if buttonState == state {
            buttonState = state
        }
    }
    
    fileprivate func completeInit() {
        isUserInteractionEnabled = true
        self.name = buttonName
    }
    
    /*
     * Needed to stop XCode warnings
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDisabled {
            buttonState = .highlighted
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDisabled {
            buttonState = .normal
            
            if buttonFunc != nil {
                if let touch = touches.first {
                    let location = touch.location(in: parent!)
                    if self.contains(location) {
                        buttonFunc!(self)
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDisabled {
            buttonState = .normal
        }
    }
    
}
