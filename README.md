# SDWebImagePINPlugin

[![CI Status](https://img.shields.io/travis/SDWebImage/SDWebImagePINPlugin.svg?style=flat)](https://travis-ci.org/SDWebImage/SDWebImagePINPlugin)
[![Version](https://img.shields.io/cocoapods/v/SDWebImagePINPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImagePINPlugin)
[![License](https://img.shields.io/cocoapods/l/SDWebImagePINPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImagePINPlugin)
[![Platform](https://img.shields.io/cocoapods/p/SDWebImagePINPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImagePINPlugin)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/SDWebImage/SDWebImagePINPlugin)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![codecov](https://codecov.io/gh/SDWebImage/SDWebImagePINPlugin/branch/master/graph/badge.svg)](https://codecov.io/gh/SDWebImage/SDWebImagePINPlugin)


## What's for
SDWebImagePINPlugin is a plugin for [SDWebImage](https://github.com/rs/SDWebImage/) framework, which provide the image loading support for [PINCache](https://github.com/pinterest/PINCache) cache system.

You use `PINCache` instead of `SDImageCache` for image cache system, which may better memory cache performance (By taking advanced of LRU algorithm), and disk cache performance (By taking advanced of queue management and age/bytes LRU algorithm)

## Usage

#### PINCache
To enable `PINCache` instead of `SDImageCache`, you can bind the cache for shared manager, or create a custom manager instead.

+ Objective-C

```objectivec
// Use `PINCache` for shared manager
SDWebImageManger.defaultImageCache = [PINCache cacheWithName:@"name"];
```

+ Swift

```swift
// Use `PINCache` for shared manager
SDWebImageManger.defaultImageCache = PINCache(name: "name")
```

You can also attach the custom cache for individual image requests via `.imageCache` context option.

+ Objective-C

```objectivec
// Use `PINCache` for single URL request
[imageView sd_setImageWithURL:url placeholderImage:nil options:0 context:@{SDWebImageContextImageCache: @(pinCache)} progress:nil completion:completion];
```

+ Swift

```swift
// Use `PINCache` for single URL request
imageView.sd_setImage(with: url, placeholderImage: nil, context: [.imageCache : pinCache], progress: nil, completion: completion);
```

### PINDiskCache && PINMemoryCache

You can also use `PINMemoryCache` or `PINDiskcache` to customize memory cache / disk cache only. See [Custom Cache](https://github.com/rs/SDWebImage/wiki/Advanced-Usage#custom-cache-50) wiki in SDWebImage.

+ Objective-C

```objectivec
// Use `PINMemoryCache` for shared `SDImageCache` memory cache implementation
SDImageCacheConfig.defaultCacheConfig.memoryCacheClass = PINMemoryCache.class;
// Use `PINDiskcache` for shared `SDImageCache` disk cache implementation
SDImageCacheConfig.defaultCacheConfig.diskCacheClass = PINDiskcache.class;
```

+ Swift

```swift
// Use `PINMemoryCache` for `SDImageCache` memory cache implementation
SDImageCacheConfig.default.memoryCacheClass = PINMemoryCache.self
// Use `PINDiskcache` for `SDImageCache` disk cache implementation
SDImageCacheConfig.default.diskCacheClass = PINDiskcache.self
```

## Requirements

+ iOS 9+
+ tvOS 9+
+ macOS 10.11+
+ watchOS 2.0+
+ Xcode 11+

## Installation

#### CocoaPods

SDWebImagePINPlugin is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SDWebImagePINPlugin'
```

#### Carthage

SDWebImageFLPlugin is available through [Carthage](https://github.com/Carthage/Carthage).

```
github "SDWebImage/SDWebImagePINPlugin"
```

#### Swift Package Manager (Xcode 11+)

SDWebImagePhotosPlugin is available through [Swift Package Manager](https://swift.org/package-manager).

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImagePINPlugin.git", from: "0.3.0")
    ]
)
```

## Author

DreamPiggy, lizhuoli1126@126.com

## License

SDWebImagePINPlugin is available under the MIT license. See the LICENSE file for more info.


