# DRRouter

[![CI Status](https://img.shields.io/travis/3257468284@qq.com/DRRouter.svg?style=flat)](https://travis-ci.org/3257468284@qq.com/DRRouter)
[![Version](https://img.shields.io/cocoapods/v/DRRouter.svg?style=flat)](https://cocoapods.org/pods/DRRouter)
[![License](https://img.shields.io/cocoapods/l/DRRouter.svg?style=flat)](https://cocoapods.org/pods/DRRouter)
[![Platform](https://img.shields.io/cocoapods/p/DRRouter.svg?style=flat)](https://cocoapods.org/pods/DRRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DRRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DRRouter'
```
## E.g.

[DRRouter registerHost:@{@"two":@"TwoViewController"}];

UIViewController *vc = [DRRouter router:@"path://two?text=abc&textId=13"];

[vc setValue:[UIImage imageNamed:@"LanchImagebg01"] forKey:@"aa"];

[self presentViewController:vc animated:YES completion:nil];

[DRRouter sendMessage:vc action:@"abc" param:nil];

[DRRouter sendMessage:vc action:@"abc:" param:@"哈哈"];

[DRRouter sendMessage:vc action:@"abc" param:@"嘿嘿"];
## Author

3257468284@qq.com, libaoxi@yuelvhui.com

## License

DRRouter is available under the MIT license. See the LICENSE file for more info.
