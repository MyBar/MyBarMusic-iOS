# MyBarMusic for iOS #

## Build Instructions

### Download Xcode

At the moment *MyBarMusic for iOS requires Swift 4.0 and Xcode 9.0 or newer. Previous versions of Xcode can be [downloaded from Apple](https://developer.apple.com/downloads/index.action).*

#### CocoaPods

MyBarMusic for iOS uses [CocoaPods](http://cocoapods.org/) to manage third party libraries.
Trying to build the project by itself (MyBarMusic.xcproj) after launching will result in an error, as the resources managed by CocoaPods are not included. To install and configure the third party libraries just run the following in the command line:

`pod install`

### Open Xcode

You can open the project by double clicking on MyBarMusic.xcworkspace file, or launching Xcode and choose File > Open and browse to MyBarMusic.xcworkspace.

