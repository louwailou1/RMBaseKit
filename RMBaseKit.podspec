Pod::Spec.new do |s|

  s.name         = "RMBaseKit"
  s.version      = "1.0"
  s.summary      = "RMBaseKit."
  s.description  = <<-DESC
                    this is RMBaseKit
                   DESC
  s.homepage     = "https://gitlab.com/RMBaseKit"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "RMBaseKit" => "RMBaseKit@msn.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://gitlab.com/RMBaseKit.git", :tag => s.version.to_s }
  s.source_files  = "RMBaseKit/RMBaseKit/**/*.{h,m,swift}"
  s.requires_arc = true
  s.dependency "MBProgressHUD"
end
