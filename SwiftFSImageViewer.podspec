Pod::Spec.new do |s|
  s.name         = "SwiftFSImageViewer"
  s.version      = "1.1"
  s.summary      = "A light framework that simulate WeiXin's image viewer."

  s.homepage     = "https://github.com/ldjhust/FSImageViewer"

  s.license      = { :type => "MIT" }
  s.author             = { "ldjhust" => "lidongjie2008@gmail.com" }

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/ldjhust/FSImageViewer.git", :tag => "1.1" }
  s.source_files  = "FSImageViewerDemo/FSImageViewerDemo/FSImageViewer/*.swift"

  s.requires_arc = true
end
