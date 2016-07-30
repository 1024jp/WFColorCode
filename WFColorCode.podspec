Pod::Spec.new do |s|
  s.name         = "WFColorCode"
  s.version      = "2.0.0"
  s.summary      = "NSColor category adding ability to handle HSL color space and CSS3 style color codes like hex, rgb() or hsla()."

  s.homepage     = "https://github.com/1024jp/WFColorCode"
  s.license      = { :type => "MIT",
                     :file => "LICENSE" }
  s.author       = { "1024jp" => "1024jp@wolfrosch.com" }

  s.platform     = :osx, '10.9'
  s.source       = { :git => "https://github.com/1024jp/WFColorCode.git",
                     :tag => s.version }

  s.source_files = 'Classes/*.swift'
  s.frameworks   = "Foundation", "AppKit"
  s.requires_arc = true
  s.compiler_flags = '-fmodules'
end
