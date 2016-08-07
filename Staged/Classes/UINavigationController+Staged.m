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
NSString * const STGViewControllerWasPoppedToRootNotificationName = @"STGViewControllerWasPoppedToRootNotificationName";

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
    return nil;
}

- (NSArray<UIViewController *> *)stg_popToRootViewControllerAnimated:(BOOL)flag {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STGViewControllerWasPoppedToRootNotificationName
                      object:nil
                    userInfo:@{STGViewControllerPoppingAnimatedKey: @(flag)}];
    return @[];
}

@end
