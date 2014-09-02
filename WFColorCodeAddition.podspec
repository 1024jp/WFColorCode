Pod::Spec.new do |s|
  s.name         = "WFColorCodeAddition"
  s.version      = "0.2"
  s.summary      = "NSColor category adding ability to handle CSS3 style color codes like Hex, rgb() or hsla()"

  s.homepage     = "https://github.com/1024jp/WFColorCodeAddition"
  s.license      = { :type => "MIT",
                     :file => "LICENSE" }
  s.authors      = { "1024jp" => '1024jp@wolfrosch.com' }

  s.platform     = :osx, '10.7'
  s.source       = { :git => "https://github.com/1024jp/WFColorCodeAddition.git"
                     :tag => s.version }

  s.source_files = 'NSColor+WFColorCodeAddition.{h,m}'
  s.requires_arc = true
  s.compiler_flags = '-fmodules'
end
