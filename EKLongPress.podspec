#
#  Be sure to run `pod spec lint EKFieldMask.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "EKLongPress"
  spec.version      = "1.0.1"
  spec.summary      = "The unique cellular number mask that appears when the user starts typing numbers. 🔥🔥🔥🔥"
  spec.description  = "In some cases, during the process registration, cannot design through social networks like e-wallets, bank accounts, etc. In such cases, usually, in applications, for ease of use, developed a particular form for a phone number with a pre-selected country code and convenient number entry. But exist the case when users also should be able to sign up by e-mail. For such an example, we have designed the unique cellular number mask that appears when the user starts typing numbers."
  spec.homepage     = "https://github.com/ekamalov/EKLongPress"
  # spec.screenshots  = "https://github.com/ekamalov/MediaFiles/blob/master/EKMaskField.gif"
  spec.license      = "MIT"
  spec.swift_version = "5.0"
  spec.ios.deployment_target = "12.2"
  spec.author       = { "Erik Kamalov" => "ekamalov967@gmail.com" }
  spec.source       = { :git => "https://github.com/ekamalov/EKLongPress.git", :tag => spec.version }
  spec.source_files = 'Source/**/*.swift'
end
