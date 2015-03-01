// ---------------------------------------
// Sprite definitions for 'buttons'
// Generated with TexturePacker 3.6.0
//
// http://www.codeandweb.com/texturepacker
// ---------------------------------------

import SpriteKit


class Buttons {

    // sprite names
    let BACK         = "back"
    let BACK_D       = "back_d"
    let BACK_X       = "back_x"
    let BUY          = "buy"
    let BUY_D        = "buy_d"
    let GREENBUTTON  = "greenbutton"
    let YELLOWBUTTON = "yellowbutton"


    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "buttons")


    // individual texture objects
    func back() -> SKTexture         { return textureAtlas.textureNamed(BACK) }
    func back_d() -> SKTexture       { return textureAtlas.textureNamed(BACK_D) }
    func back_x() -> SKTexture       { return textureAtlas.textureNamed(BACK_X) }
    func buy() -> SKTexture          { return textureAtlas.textureNamed(BUY) }
    func buy_d() -> SKTexture        { return textureAtlas.textureNamed(BUY_D) }
    func greenbutton() -> SKTexture  { return textureAtlas.textureNamed(GREENBUTTON) }
    func yellowbutton() -> SKTexture { return textureAtlas.textureNamed(YELLOWBUTTON) }

}
