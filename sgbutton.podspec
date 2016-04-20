Pod::Spec.new do |s|
  s.name         = "sgbutton"
  s.version      = "0.0.1"
  s.summary      = "Button library for SpriteKit in Swift"
  s.homepage     = "http://softgaroo.com"
  s.license      = "MIT"
  s.author             = { "nguyenpham" => "axchess@yahoo.com" }

  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/nguyenpham/sgbutton.git", :tag => s.version }

  s.source_files  = "SgButton/*.swift"
end
