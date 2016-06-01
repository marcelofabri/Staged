//
//  UIViewController+Staged.h
//  Staged
//
//  Created by Marcelo Fabri on 01/06/16.
//
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const STGViewControllerWasPresentedNotificationName;
FOUNDATION_EXPORT NSString *const STGViewControllerWasDismissedNotificationName;

FOUNDATION_EXPORT NSString *const STGViewControllerPresentationAnimatedKey;
FOUNDATION_EXPORT NSString *const STGViewControllerPresentationPresenterViewControllerKey;

@interface UIViewController (Staged)

+ (void)stg_swizzle;

@end
