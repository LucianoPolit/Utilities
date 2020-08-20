Pod::Spec.new do |s|

  s.name             = 'AwesomeUtilitiesTests'
  s.version          = '1.7.0'
  s.summary          = 'Swift Common Utilities Tests'
  s.description      = <<-DESC
                          Swift Common Utilities Tests.
                          DESC
  s.homepage         = 'https://github.com/lucianopolit/Utilities'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luciano Polit' => 'lucianopolit@gmail.com' }
  s.source           = { :git => 'https://github.com/lucianopolit/Utilities.git', :tag => s.version.to_s }
  s.platform         = :ios, "8.0"
  s.swift_version    = '5.0'

  s.subspec 'Tests' do |ss|
    ss.source_files  = 'Source/Tests/*.swift'
    ss.dependency      'AwesomeUtilities/Core'
  end

end
