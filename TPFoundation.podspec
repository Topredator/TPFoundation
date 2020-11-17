#
# Be sure to run `pod lib lint TPFoundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TPFoundation'
  s.version          = '1.0.1'
  s.summary          = 'A collection function library of TPFoundation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Topredator/TPFoundation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Topredator' => 'luyanggold@163.com' }
  s.source           = { :git => 'https://github.com/Topredator/TPFoundation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TPFoundation/Classes/TPFoundation.h'
  
  s.subspec 'Base' do |ss|
      ss.source_files = 'TPFoundation/Classes/Base/**/*'
  end
  
  s.subspec 'Category' do |ss|
      ss.source_files = 'TPFoundation/Classes/Category/**/*'
      ss.dependency 'TPFoundation/Base'
  end
  
  s.subspec 'Utils' do |ss|
      ss.source_files = 'TPFoundation/Classes/Utils/**/*'
      ss.dependency 'TPFoundation/Base'
      ss.dependency 'TPFoundation/Category'
  end
  
  # s.resource_bundles = {
  #   'TPFoundation' => ['TPFoundation/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
