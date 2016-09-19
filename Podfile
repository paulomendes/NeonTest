source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'

inhibit_all_warnings!

def shared_pods
	pod 'AFNetworking'
	pod 'Mantle', '~> 2.0.6'
	pod 'ISO8601DateFormatter', '~> 0.7'
	pod "UIImageView-Letters"
	pod 'STPopup'
	pod 'SVProgressHUD'
end

def install_tests_pods
	pod 'Expecta', '~> 1.0.0'
	pod 'OHHTTPStubs', '~> 4.0'
end

target "Test-Neon" do
	shared_pods
end

target "Test-NeonTests" do
    shared_pods
    install_tests_pods
end

