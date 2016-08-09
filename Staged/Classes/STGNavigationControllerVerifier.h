//
//  STGNavigationControllerVerifier.h
//  Staged
//
//  Created by Gustavo Barbosa on 7/31/16.
//
//

#import <UIKit/UIKit.h>

@interface STGNavigationControllerVerifier: NSObject

@property (nonatomic, copy, nonnull) NSArray<__kindof UIViewController *> *viewControllers;
@property (nonatomic, readonly, nonnull) __kindof UIViewController *topViewController;
@property (nonatomic) BOOL pushedAnimated;
@property (nonatomic) BOOL poppedAnimated;

@end
