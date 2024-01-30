Pod::Spec.new do |s|

  s.name             = 'AwesomeUtilities'
  s.version          = '1.10.0'
  s.summary          = 'Swift Common Utilities'
  s.description      = <<-DESC
                          Swift Common Utilities.
                          DESC
  s.homepage         = 'https://github.com/lucianopolit/Utilities'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Luciano Polit' => 'lucianopolit@gmail.com' }
  s.source           = { :git => 'https://github.com/lucianopolit/Utilities.git', :tag => s.version.to_s }
  s.platform         = :ios, "12.0"
  s.swift_version    = '5.0'

  s.subspec 'Core' do |ss|
    ss.source_files  = 'Source/Core/*.swift'
  end

  s.subspec 'Extensions' do |ss|
    ss.source_files  = 'Source/Extensions/*.swift'
    ss.dependency      'AwesomeUtilities/Core'
  end

end
