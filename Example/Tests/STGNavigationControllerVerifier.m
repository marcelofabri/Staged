//
//  STGNavigationControllerVerifier.m
//  Staged
//
//  Created by Gustavo Barbosa on 7/31/16.
//  Copyright © 2016 Marcelo Fabri. All rights reserved.
//

#import <Staged/STGNavigationControllerVerifier.h>

SpecBegin(STGNavigationControllerVerifier)

__block STGNavigationControllerVerifier *verifier;

beforeEach(^{
    verifier = [[STGNavigationControllerVerifier alloc] init];
});

describe(@"navigation controller pushing", ^{

    __block UINavigationController *currentNavigationController;
    __block UIViewController *viewControllerToPush;

    beforeEach(^{
        currentNavigationController = [[UINavigationController alloc] init];
        viewControllerToPush = [[UIViewController alloc] init];
    });

    it(@"has empty properties by default", ^{
        expect(verifier.viewControllers).to.beEmpty();
        expect(verifier.pushedAnimated).to.beFalsy();
    });

    it(@"stores properties", ^{
        [currentNavigationController pushViewController:viewControllerToPush animated:YES];

        expect(verifier.viewControllers).to.haveCountOf(1);
        expect(verifier.viewControllers.lastObject).to.equal(viewControllerToPush);
        expect(verifier.pushedAnimated).to.beTruthy();
    });
});

describe(@"navigation controller popping", ^{

    __block UINavigationController *navigationController;
    __block UIViewController *rootViewController;

    beforeEach(^{
        navigationController = [[UINavigationController alloc] init];

        rootViewController = [[UIViewController alloc] init];
        [navigationController pushViewController:rootViewController animated:NO];
    });

    it(@"has empty properties by default", ^{
        expect(verifier.poppedAnimated).to.beFalsy();
    });

    it(@"stores properties", ^{
        [navigationController popViewControllerAnimated:YES];

        expect(verifier.poppedAnimated).to.beTruthy();
        expect(verifier.viewControllers).to.beEmpty();
    });

    it(@"can pop 1 element", ^{
        UIViewController *fooViewController = [[UIViewController alloc] init];
        [navigationController pushViewController:fooViewController animated:YES];

        [navigationController popViewControllerAnimated:YES];

        expect(verifier.viewControllers).to.haveCountOf(1);
    });
});

SpecEnd