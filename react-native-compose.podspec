require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-compose"
  s.version      = package["version"]
  s.summary      = "Compose text messages and emails from within React Native apps"
  s.homepage     = "https://github.com/fjcaetano/react-native-compose"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Flávio Caetano' => 'flavio@vieiracaetano.com' }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/fjcaetano/react-native-compose.git", :tag => s.version.to_s }
  s.social_media_url  = 'https://twitter.com/flavio_caetano'

  s.source_files  = "ios/**/*.{h,m}"

  s.dependency "React"
end
