//
//  UIViewController+StagedSwizziling.h
//  Pods
//
//  Created by Gustavo Barbosa on 7/31/16.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (StagedSwizziling)

+ (void)stg_replaceInstanceMethod:(SEL)original withMethod:(SEL)swizzled;

@end
