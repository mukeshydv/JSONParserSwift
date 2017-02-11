#
# Be sure to run `pod lib lint JSONParserSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'JSONParserSwift'
s.version          = '0.1.2'
s.summary          = 'Parse your JSON data directly to Swift object.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Parse your JSON data directly to Swift object.
Server sends the all JSON data in black & white format i.e its all strings & we make hard efforts to typecast them into their respective datatypes as per our model class.

Now, Is there a magic that comes between the server data and our code magically converts those strings into the required respective datatypes as per our model classes.
DESC

s.homepage         = 'https://github.com/mukeshydv/JSONParserSwift'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'mukeshydv' => 'mails4ymukesh@gmail.com' }
s.source           = { :git => 'https://github.com/mukeshydv/JSONParserSwift.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'JSONParserSwift/Classes/**/*'

# s.resource_bundles = {
#   'JSONParserSwift' => ['JSONParserSwift/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
