//
//  STGViewControllerVerifier.h
//  Staged
//
//  Created by Marcelo Fabri on 01/06/16.
//
//

#import <UIKit/UIKit.h>

@interface STGViewControllerVerifier : NSObject

@property (nonatomic) NSUInteger presentedCount;
@property (nonatomic, strong, nullable) __kindof UIViewController *presentedViewController;
@property (nonatomic, strong, nullable) __kindof UIViewController *presenterViewController;
@property (nonatomic) BOOL presentedAnimated;

@property (nonatomic) NSUInteger dismissedCount;
@property (nonatomic, strong, nullable) __kindof UIViewController *dismissedViewController;
@property (nonatomic) BOOL dismissedAnimated;

@end
