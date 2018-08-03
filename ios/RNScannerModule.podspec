
Pod::Spec.new do |s|
  s.name         = "RNScannerModule"
  s.version      = "1.0.0"
  s.summary      = "RNScannerModule"
  s.description  = <<-DESC
                  RNScannerModule
                   DESC
  s.homepage     = "https://github.com/michaelgardiner97/scannermodule.git"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/author/RNScannerModule.git", :tag => "master" }
  s.source_files  = "**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "WeScan"
  #s.dependency "others"

end
