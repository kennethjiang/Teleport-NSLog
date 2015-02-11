#
# Be sure to run `pod lib lint Teleport.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Teleport-NSLog"
  s.version          = "0.1.1"
  s.summary          = "Remote logging for iOS. Send NSLog messages to backend server."
  s.homepage         = "https://github.com/kennethjiang/Teleport"
  s.license          = 'MIT'
  s.author           = { "Kenneth Jiang" => "kenneth.jiang@gmail.com" }
  s.source           = { :git => "https://github.com/kennethjiang/Teleport.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.{h,m}', 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'Teleport' => ['Pod/Assets/*.png']
  }

  s.library = 'z'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  #s .frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
