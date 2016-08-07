//
//  STGNavigationControllerVerifier.m
//  Staged
//
//  Created by Gustavo Barbosa on 7/31/16.
//
//

#import "STGNavigationControllerVerifier.h"
#import "UINavigationController+Staged.h"

@implementation STGNavigationControllerVerifier

static void swizzleMocks() {
    [UINavigationController stg_swizzle];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _viewControllers = @[];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(viewControllerWasPushed:)
                                                     name:STGViewControllerWasPushedNotificationName
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(viewControllerWasPopped:)
                                                     name:STGViewControllerWasPoppedNotificationName
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(navigationWasPoppedToRoot:)
                                                     name:STGViewControllerWasPoppedToRootNotificationName
                                                   object:nil];

        swizzleMocks();
    }

    return self;
}

- (void)dealloc {
    swizzleMocks();
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIViewController  * _Nullable )topViewController {
    return _viewControllers.lastObject;
}

- (void)viewControllerWasPushed:(NSNotification *)notification {
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    [viewControllers addObject:notification.object];
    self.viewControllers = viewControllers;
    self.pushedAnimated = [notification.userInfo[STGViewControllerPushingAnimatedKey] boolValue];
}

- (void)viewControllerWasPopped:(NSNotification *)notification {
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    [viewControllers removeLastObject];
    self.viewControllers = viewControllers;
    self.poppedAnimated = [notification.userInfo[STGViewControllerPoppingAnimatedKey] boolValue];
}

- (void)navigationWasPoppedToRoot:(NSNotification *)notification {
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    while (viewControllers.count > 1) {
        [viewControllers removeLastObject];
    }
    self.viewControllers = viewControllers;
    self.poppedAnimated = [notification.userInfo[STGViewControllerPoppingAnimatedKey] boolValue];
}

@end
