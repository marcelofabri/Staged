//
//  UINavigationController+Staged.m
//  Staged
//
//  Created by Gustavo Barbosa on 7/31/16.
//
//

#import "UINavigationController+Staged.h"
#import "UIViewController+StagedSwizziling.h"

NSString * const STGViewControllerWasPushedNotificationName = @"STGViewControllerWasPushedNotificationName";
NSString * const STGViewControllerWasPoppedNotificationName = @"STGViewControllerWasPoppedNotificationName";
NSString * const STGNavigationControllerWasPoppedToRootNotificationName = @"STGNavigationControllerWasPoppedToRootNotificationName";
NSString * const STGNavigationControllerWasPoppedToViewControllerNotificationName = @"STGNavigationControllerWasPoppedToViewControllerNotificationName";
NSString * const STGNavigationControllerItemsWereSetNotificationName = @"STGNavigationControllerItemsWereSetNotificationName";

NSString * const STGViewControllerPushingAnimatedKey = @"STGViewControllerPushingAnimatedKey";
NSString * const STGViewControllerPoppingAnimatedKey = @"STGViewControllerPoppingAnimatedKey";

@implementation UINavigationController (Staged)

+ (void)stg_swizzle {
    [self stg_replaceInstanceMethod:@selector(pushViewController:animated:)
                         withMethod:@selector(stg_pushViewController:animated:)];

    [self stg_replaceInstanceMethod:@selector(popViewControllerAnimated:)
                         withMethod:@selector(stg_popViewControllerAnimated:)];

    [self stg_replaceInstanceMethod:@selector(popToRootViewControllerAnimated:)
                         withMethod:@selector(stg_popToRootViewControllerAnimated:)];

    [self stg_replaceInstanceMethod:@selector(popToViewController:animated:)
                         withMethod:@selector(stg_popToViewController:animated:)];

    [self stg_replaceInstanceMethod:@selector(setViewControllers:animated:)
                         withMethod:@selector(stg_setViewControllers:animated:)];
}

- (void)stg_pushViewController:(UIViewController *)viewControllerToPush
                      animated:(BOOL)flag {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STGViewControllerWasPushedNotificationName
                      object:viewControllerToPush
                    userInfo:@{STGViewControllerPushingAnimatedKey: @(flag)}];
}

- (nullable UIViewController *)stg_popViewControllerAnimated:(BOOL)flag {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STGViewControllerWasPoppedNotificationName
                      object:self.topViewController
                    userInfo:@{STGViewControllerPoppingAnimatedKey: @(flag)}];
    return self.topViewController;
}

- (NSArray<UIViewController *> *)stg_popToRootViewControllerAnimated:(BOOL)flag {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STGNavigationControllerWasPoppedToRootNotificationName
                      object:nil
                    userInfo:@{STGViewControllerPoppingAnimatedKey: @(flag)}];

    if (self.viewControllers.count == 0) {
        return @[];
    }

    return [self.viewControllers subarrayWithRange:NSMakeRange(1, self.viewControllers.count - 1)];
}

- (NSArray<UIViewController *> *)stg_popToViewController:(UIViewController *)viewControllerToStayOnTop
                                            animated:(BOOL)flag {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STGNavigationControllerWasPoppedToViewControllerNotificationName
                      object:viewControllerToStayOnTop
                    userInfo:@{STGViewControllerPoppingAnimatedKey: @(flag)}];

    NSUInteger topViewControllerIndex = [self.viewControllers indexOfObject:viewControllerToStayOnTop];
    if (topViewControllerIndex == NSNotFound) {
        return @[];
    }

    NSRange range = NSMakeRange(topViewControllerIndex, self.viewControllers.count - topViewControllerIndex);
    return [self.viewControllers subarrayWithRange:range];
}

- (void)stg_setViewControllers:(NSArray<UIViewController *> *)viewControllersToSet
                      animated:(BOOL)flag {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STGNavigationControllerItemsWereSetNotificationName
                      object:viewControllersToSet
                    userInfo:@{STGViewControllerPushingAnimatedKey: @(flag)}];
}

@end
