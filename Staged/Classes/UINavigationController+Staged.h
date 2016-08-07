//
//  UINavigationController+Staged.h
//  Staged
//
//  Created by Gustavo Barbosa on 7/31/16.
//
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const STGViewControllerWasPushedNotificationName;
FOUNDATION_EXPORT NSString *const STGViewControllerWasPoppedNotificationName;
FOUNDATION_EXPORT NSString *const STGNavigationControllerWasPoppedToRootNotificationName;
FOUNDATION_EXPORT NSString *const STGNavigationControllerWasPoppedToViewControllerNotificationName;
FOUNDATION_EXPORT NSString *const STGNavigationControllerItemsWereSetNotificationName;

FOUNDATION_EXPORT NSString *const STGViewControllerPushingAnimatedKey;
FOUNDATION_EXPORT NSString *const STGViewControllerPoppingAnimatedKey;

@interface UINavigationController (Staged)

+ (void)stg_swizzle;

@end
