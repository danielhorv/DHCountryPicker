
Pod::Spec.new do |spec|
  spec.name         = "DHCountryPicker"
  spec.version      = "0.1.3"
  spec.summary      = "Country Picker library for iOS"
  spec.description  = <<-DESC
                    Country picker with phone numbers for iOS
                   DESC
  spec.homepage     = "https://github.com/danielhorv"
  spec.license      = "MIT"
  spec.author             = "Daniel Horvath"
  spec.social_media_url   = "https://twitter.com/picipuma"
  spec.platform     = :ios
  spec.platform     = :ios, "11.0"
  spec.swift_version = '5.0'
  spec.source       = { :git => "https://github.com/danielhorv/DHCountryPicker.git", :tag => "#{spec.version}" }
  spec.source_files  = "DHCountryPicker/**/*.swift"

  spec.resources = "DHCountryPicker/**/*.json"
  spec.dependency 'FlagKit'

end
