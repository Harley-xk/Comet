#
# Be sure to run `pod lib lint Comet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Comet'
  s.version          = '2.0.0'
  s.summary          = 'iOS 项目的 Swift 基础库，提供一些常用组件、便利方法等。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                从 2.0 版本起默认集成网络层框架，处理请求-数据-模型的完整逻辑流程。如果不需要该功能，可以使用 pod 'Comet/Basic' 指定只引入基础工具包
                       DESC

  s.homepage         = 'https://github.com/Harley-xk/Comet'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Harley.xk' => 'harley.gb@foxmail.com' }
  s.source           = { :git => 'https://github.com/Harley-xk/Comet.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.subspec 'Basic' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files = 'Comet/Basic/**/*'
  end
  
  s.subspec 'Networking' do |ss|
      ss.ios.deployment_target = '9.0'
      ss.source_files = 'Comet/Networking/**/*'
      ss.dependency 'Comet/Basic'
      ss.dependency 'Alamofire'
  end
  
  # s.resource_bundles = {
  #   'Comet' => ['Comet/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
