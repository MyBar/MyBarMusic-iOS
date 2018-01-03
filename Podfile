## Import CocoaPods sources
source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!
use_frameworks!

platform :ios, '9.0'
workspace 'MyBarMusic.xcworkspace'

## Pods shared between all the targets
def shared_with_networking_pods
    pod 'Alamofire', '4.5'
end

def shared_with_webimage_pods
    # Kingfisher is a lightweight, pure-Swift library for downloading and caching images from the web.
    pod 'Kingfisher', '~> 4.0'
end

def shared_with_json_pods
    pod 'HandyJSON', '4.0.0-beta.1’
end

target ‘MyBarMusic' do
    project 'MyBarMusic/MyBarMusic.xcodeproj'

    shared_with_networking_pods
    shared_with_webimage_pods
    shared_with_json_pods

    # ---------------------
    # Third party libraries
    # ---------------------
    pod 'SlideMenuControllerSwift', :git => 'https://github.com/dekatotoro/SlideMenuControllerSwift', :branch => 'swift4'
    pod 'Reachability', '3.2'
end
