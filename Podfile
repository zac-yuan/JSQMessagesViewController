source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Babylonpartners/ios-private-podspecs.git'

platform :ios, '8.0'
inhibit_all_warnings!
use_frameworks!

target :JSQMessages do
    pod 'JSQSystemSoundPlayer', '~> 2.0'
end

target :BabylonBotDemo do
    inherit! :search_paths

    pod 'JSQSystemSoundPlayer', '~> 2.0'
    pod 'AFNetworking', '~> 2.0'
    pod 'AFNetworkActivityLogger'
    pod 'AfroLayout'
    pod 'ios-maps'
    pod 'PubNub'
    pod 'OHHTTPStubs'
end

target 'BabylonBotDemoTests' do
    pod 'Quick'
    pod 'Nimble'
end
