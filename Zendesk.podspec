require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |spec|
  spec.name           = "Zendesk"
  spec.version        = package["version"]
  spec.summary        = package["description"]
  spec.description    = package["description"]
  spec.homepage       = package['homepage']
  spec.license        = package['license']
  spec.author         = package['author']
  spec.source         = { git: "https://github.com/PabloGiraudCarrier/react-native-zendesk.git" }
  spec.requires_arc   = true
  spec.platform       = :ios, "10.0"

  spec.source_files   = 'ios/*.{h,m}'

  spec.dependency 'React'
  spec.dependency 'ZendeskSupportProvidersSDK'
end
