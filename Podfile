platform :ios, '9.0' # support Alamofire 4.x we have to set minimum version to 9.0.
use_frameworks!

target 'PlayGoTest' do

pod 'SDWebImage', '~> 4.0'


end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['SWIFT_VERSION'] = '3.0' # for Swift 2.3 use config.build_settings['SWIFT_VERSION'] = '2.3'
end
end
end
