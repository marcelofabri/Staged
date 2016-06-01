Pod::Spec.new do |s|
  s.name             = 'Staged'
  s.version          = '0.1.0'
  s.summary          = 'Mock View Controllers presentations and dismissals on unit tests'
  s.description      = <<-DESC
Staged allows you to easily mock View Controllers presentations and dismissals, so you don't have to create a window just to test them.
                       DESC

  s.homepage         = 'https://github.com/marcelofabri/Staged'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marcelo Fabri' => 'me@marcelofabri.com' }
  s.source           = { :git => 'https://github.com/marcelofabri/Staged.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marcelofabri_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Staged/Classes/**/*'
  
  s.public_header_files = 'Staged/Classes/STGViewControllerVerifier.h'
  s.frameworks = 'UIKit'
end
