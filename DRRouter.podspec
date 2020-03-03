#
# Be sure to run `pod lib lint DRRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DRRouter'
  s.version          = '0.0.1'
  s.summary          = 'DR的路由，只用于组件之间的跳转'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
DR的中间件路由，只用于组件之间的跳转.
                       DESC

  s.homepage         = 'https://www.baidu.com'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '3257468284@qq.com' => 'libaoxi@yuelvhui.com' }
  s.source           = { :git => 'https://github.com/bestColor/DRRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DRRouter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DRRouter' => ['DRRouter/Assets/*.png']
  # }

#   s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'Foundation'
#   s.dependency 'AFNetworking', '~> 2.3'
end
