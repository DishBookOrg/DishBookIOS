source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '14.1'

use_frameworks!
inhibit_all_warnings!

target 'DishBookIOS' do

  # Pods for DishBookIOS
  pod 'SwiftLint'
  pod 'R.swift', '~> 5'
  pod 'SVProgressHUD'
  pod 'Default', '~> 3.0'
  pod 'Wormholy'

  pod 'GoogleSignIn'
  
  pod 'FirebaseUI/Storage'
  pod 'CombineFirebase/Firestore'
  pod 'CombineFirebase/RemoteConfig'
  pod 'CombineFirebase/Database'
  pod 'CombineFirebase/Storage'
  pod 'CombineFirebase/Auth'
  pod 'CombineFirebase/Functions'
#  pod 'Firebase/Analytics'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

