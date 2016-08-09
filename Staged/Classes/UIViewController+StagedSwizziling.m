//
//  UIViewController+StagedSwizziling.m
//  Pods
//
//  Created by Gustavo Barbosa on 7/31/16.
//
//

#import "UIViewController+StagedSwizziling.h"
#import <objc/runtime.h>

@implementation UIViewController (StagedSwizziling)

+ (void)stg_replaceInstanceMethod:(SEL)original withMethod:(SEL)swizzled {
    Method originalMethod = class_getInstanceMethod(self, original);
    Method swizzledMethod = class_getInstanceMethod(self, swizzled);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end
