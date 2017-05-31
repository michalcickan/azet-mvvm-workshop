source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

def shared_pods
pod 'Alamofire', '~> 4.0'
pod 'AsyncSwift'
pod 'ObjectMapper'

end

target 'ProtocolOrientedMVVMWorkshop' do
shared_pods

pod 'RealmSwift'
pod 'AsyncSwift'
pod 'AlamofireImage'
end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['ENABLE_BITCODE'] = 'NO'
config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
end
end
end
