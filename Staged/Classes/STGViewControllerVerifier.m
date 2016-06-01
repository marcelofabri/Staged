//
//  STGViewControllerVerifier.h
//  Staged
//
//  Created by Marcelo Fabri on 01/06/16.
//
//

#import "STGViewControllerVerifier.h"
#import "UIViewController+Staged.h"

@implementation STGViewControllerVerifier

static void swizzleMocks() {
    [UIViewController stg_swizzle];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(viewControllerWasPresented:)
                                                     name:STGViewControllerWasPresentedNotificationName
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(viewControllerWasDismissed:)
                                                     name:STGViewControllerWasDismissedNotificationName
                                                   object:nil];
        swizzleMocks();
    }

    return self;
}

- (void)dealloc {
    swizzleMocks();
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewControllerWasPresented:(NSNotification *)notification {
    self.presentedCount++;
    self.presentedAnimated = [notification.userInfo[STGViewControllerPresentationAnimatedKey] boolValue];
    self.presentedViewController = notification.object;
    self.presenterViewController = notification.userInfo[STGViewControllerPresentationPresenterViewControllerKey];
}

- (void)viewControllerWasDismissed:(NSNotification *)notification {
    self.dismissedCount++;
    self.dismissedViewController = notification.object;
    self.dismissedAnimated = [notification.userInfo[STGViewControllerPresentationAnimatedKey] boolValue];
}

@end
