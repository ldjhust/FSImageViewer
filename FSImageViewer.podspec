Pod::Spec.new do |s|
  s.name         = "FSImageViewer"
  s.version      = "1.0"
  s.summary      = "A light framework that simulate WeiXin's image viewer."
  # s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/ldjhust/FSImageViewer"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT" }
  s.author             = { "ldjhust" => "lidongjie2008@gmail.com" }

  s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"

  s.source       = { :git => "https://github.com/ldjhust/FSImageViewer.git", :tag => "1.0" }

  s.source_files  = "FSImageViewerDemo/FSImageViewerDemo/FSImageViewer/*.swift"
end
