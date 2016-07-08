source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Babylonpartners/ios-private-podspecs.git'

platform :ios, '8.3'
use_frameworks!
inhibit_all_warnings!

target :JSQMessages do
    pod 'JSQSystemSoundPlayer', '~> 2.0'
    pod 'ios-foundation', :git => 'git@github.com:Babylonpartners/ios-foundation.git', :branch => 'master'
end

target :BabylonBotDemo do
    pod 'JSQSystemSoundPlayer', '~> 2.0'
    pod 'AFNetworking', '~> 2.0'
    pod 'AFNetworkActivityLogger'
    pod 'ios-maps'
    pod 'PubNub'
    pod 'OHHTTPStubs'
end

target 'BabylonBotDemoTests' do
    pod 'Quick'
    pod 'Nimble'
end
