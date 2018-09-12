#
#  Be sure to run `pod spec lint GLSlider.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "GLSlider"
  s.version      = "1.0.2"
  s.summary      = "滑块控件，类似于系统UISlider"
  s.homepage     = "https://github.com/colynlei/GLSlider"
  s.license      = "MIT"
  s.author       = { "『国』" => "leiguolin@huobi.com" }
  s.source       = { :git => "https://github.com/colynlei/GLSlider.git", :tag => "#{s.version}" }
  s.source_files = "Classes", "GLSlider/GLSlider.{h,m}"
  s.ios.deployment_target = "8.0"
  s.requires_arc = true

end
