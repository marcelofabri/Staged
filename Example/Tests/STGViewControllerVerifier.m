//
//  STGViewControllerVerifierTests.m
//  StagedTests
//
//  Created by Marcelo Fabri on 06/01/2016.
//  Copyright (c) 2016 Marcelo Fabri. All rights reserved.
//

#import <Staged/STGViewControllerVerifier.h>

SpecBegin(STGViewControllerVerifier)

__block STGViewControllerVerifier *verifier;

beforeEach(^{
    verifier = [[STGViewControllerVerifier alloc] init];
});

describe(@"view controller presentation", ^{

    __block UIViewController *viewControllerToPresent;
    __block UIViewController *currentViewController;

    beforeEach(^{
        viewControllerToPresent = [[UIViewController alloc] init];
        currentViewController = [[UIViewController alloc] init];
    });

    it(@"has empty properties by default", ^{
        expect(verifier.presentedViewController).to.beNil();
        expect(verifier.presenterViewController).to.beNil();
        expect(verifier.presentedCount).to.equal(0);
        expect(verifier.presentedAnimated).to.beFalsy();
    });

    it(@"stores properties", ^{
        [currentViewController presentViewController:viewControllerToPresent animated:YES completion:nil];

        expect(verifier.presentedViewController).to.equal(viewControllerToPresent);
        expect(verifier.presenterViewController).to.equal(currentViewController);
        expect(verifier.presentedCount).to.equal(1);
        expect(verifier.presentedAnimated).to.beTruthy();
    });

    it(@"calls completion block", ^{
        __block BOOL calledCompletion = NO;
        [currentViewController presentViewController:viewControllerToPresent animated:YES completion:^{
            calledCompletion = YES;
        }];

        expect(calledCompletion).to.beTruthy();
    });
});

describe(@"view controller dismissal", ^{

    __block UIViewController *viewController;

    beforeEach(^{
        viewController = [[UIViewController alloc] init];
    });

    it(@"has empty properties by default", ^{
        expect(verifier.dismissedViewController).to.beNil();
        expect(verifier.dismissedCount).to.equal(0);
        expect(verifier.dismissedAnimated).to.beFalsy();
    });

    it(@"stores properties", ^{
        [viewController dismissViewControllerAnimated:YES completion:nil];

        expect(verifier.dismissedViewController).to.equal(viewController);
        expect(verifier.dismissedCount).to.equal(1);
        expect(verifier.dismissedAnimated).to.beTruthy();
    });

    it(@"calls completion block", ^{
        __block BOOL calledCompletion = NO;
        [viewController dismissViewControllerAnimated:YES completion:^{
            calledCompletion = YES;
        }];

        expect(calledCompletion).to.beTruthy();
    });
});

SpecEnd

