//
//  UIViewController+Staged.m
//  Staged
//
//  Created by Marcelo Fabri on 01/06/16.
//
//

#import "UIViewController+Staged.h"
#import <objc/runtime.h>

NSString * const STGViewControllerWasPresentedNotificationName = @"STGViewControllerPresentationNotificationName";
NSString * const STGViewControllerWasDismissedNotificationName = @"STGViewControllerWasDismissedNotificationName";

NSString * const STGViewControllerPresentationAnimatedKey = @"STGViewControllerPresentationAnimatedKey";
NSString * const STGViewControllerPresentationPresenterViewControllerKey = @"STGViewControllerPresentationPresenterViewControllerKey";

@implementation UIViewController (Staged)

+ (void)stg_replaceInstanceMethod:(SEL)original withMethod:(SEL)swizzled {
    Method originalMethod = class_getInstanceMethod(self, original);
    Method swizzledMethod = class_getInstanceMethod(self, swizzled);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)stg_swizzle {
    [self stg_replaceInstanceMethod:@selector(presentViewController:animated:completion:)
                         withMethod:@selector(stg_presentViewController:animated:completion:)];

    [self stg_replaceInstanceMethod:@selector(dismissViewControllerAnimated:completion:)
                         withMethod:@selector(stg_dismissViewControllerAnimated:completion:)];
}

- (void)stg_presentViewController:(UIViewController *)viewControllerToPresent
                         animated:(BOOL)flag
                       completion:(void (^)(void))completion {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STGViewControllerWasPresentedNotificationName
                      object:viewControllerToPresent
                    userInfo:@{STGViewControllerPresentationAnimatedKey : @(flag),
                               STGViewControllerPresentationPresenterViewControllerKey : self}];

    if (completion) {
        completion();
    }
}

- (void)stg_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:STGViewControllerWasDismissedNotificationName
                      object:self
                    userInfo:@{STGViewControllerPresentationAnimatedKey : @(flag)}];

    if (completion) {
        completion();
    }
}

@end
