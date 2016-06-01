# Staged

[![CI Status](http://img.shields.io/travis/Marcelo Fabri/Staged.svg?style=flat)](https://travis-ci.org/Marcelo Fabri/Staged)
[![Version](https://img.shields.io/cocoapods/v/Staged.svg?style=flat)](http://cocoapods.org/pods/Staged)
[![License](https://img.shields.io/cocoapods/l/Staged.svg?style=flat)](http://cocoapods.org/pods/Staged)
[![Platform](https://img.shields.io/cocoapods/p/Staged.svg?style=flat)](http://cocoapods.org/pods/Staged)

Staged allows you to easily mock View Controllers presentations and dismissals, so you don't have to create a window just to test them.

## Usage

Just import `#import <Staged/STGViewControllerVerifier.h>` and use like this:

```objc
STGViewControllerVerifier *verifier = [[STGViewControllerVerifier alloc] init];
UIViewController *viewController = [[UIViewController alloc] init];

// sut is the system under test
[sut presentSomeOtherControllerOn:viewController];

expect(verifier.presenterViewController).to.equal(viewController);
expect(verifier.presentedViewController).to.beKindOf([SomeCoolViewController class]);
expect(verifier.presentedAnimated).to.beTruthy();
expect(verifier.presentedCount).to.equal(1);
```

This is using [Expecta](https://github.com/specta/expecta) matchers, but you can be boring and use the default ones as well.

You can also check if a view controller was dismissed: 

```objc
STGViewControllerVerifier *verifier = [[STGViewControllerVerifier alloc] init];

[sut doSomethingThatShouldDismissAViewController];

expect(verifier.dismissedViewController).to.beKindOf([SomeCoolViewController class]);
expect(verifier.dimissedAnimated).to.beFalsy();
expect(verifier.dismissedCount).to.equal(1);
```

## Requirements

iOS 8

## Installation

Staged is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Staged"
```

## Author

Marcelo Fabri, me@marcelofabri.com

# Thanks

- [Jon Reid](https://twitter.com/qcoding) for creating [MockUIAlertController](https://github.com/jonreid/MockUIAlertController), from which I borrowed the idea and the initial implementation.

# Need help?

Please submit an issue on GitHub and provide information about your setup.

## License

Staged is available under the MIT license. See the LICENSE file for more info.
