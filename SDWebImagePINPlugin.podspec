#
# Be sure to run `pod lib lint SDWebImagePINPlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SDWebImagePINPlugin'
  s.version          = '0.3.0'
  s.summary          = 'A SDWebImage plugin to integrate PINCache for custom image caching.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/SDWebImage/SDWebImagePINPlugin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DreamPiggy' => 'lizhuoli1126@126.com' }
  s.source           = { :git => 'https://github.com/SDWebImage/SDWebImagePINPlugin.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'SDWebImagePINPlugin/Classes/**/*', 'SDWebImagePINPlugin/Module/SDWebImagePINPlugin.h'
  
  s.dependency 'SDWebImage/Core', '~> 5.10'
  s.dependency 'PINCache', '>= 3.0.2'
end
