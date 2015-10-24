# FSImageViewer

# Introduction
A lightweight framework that simulate WeiXin's image viewer use Swift2.0.

use Xcode 7.0 to run the sample code.

![(shown)](https://github.com/ldjhust/FSImageViewer/blob/master/demogif.gif)

### Feature
- [x] show local image view
- [ ] show remote image view with url

# Installation
### CocoaPods
To integrate FSImageViewer into your Xcode project using CocoaPods, specify it in your `Podfile` like download:

```ruby
platform :ios, '8.0'
use_frameworks!

pod 'SwiftFSImageViewer', '~> 1.1'
```

Then, run the following command line in your terminal:

```bash
$ pod install
```

### Manually
If you prefer not to use CocoaPods, you can integrate FSImageViewer into your project manually. Download the source code, and then drag the FSImageViewer/*.swift into your project.

# Usage
```swift
import SwiftFSImageViewer

FSImageViewer.sharedFSImageViewer.showImageView(self.cat1, atPoint: self.cat1.center)
```

# License

FSImageViewer is released under the MIT license. See LICENSE for details.
