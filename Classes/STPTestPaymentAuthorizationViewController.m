//
//  STPTestPaymentAuthorizationViewController.m
//  StripeExample
//
//  Created by Jack Flintermann on 9/30/14.
//  Copyright (c) 2014 Stripe. All rights reserved.
//



#import "STPTestPaymentAuthorizationViewController.h"
#import "STPTestPaymentSummaryViewController.h"

@interface STPTestPaymentAuthorizationViewController()<UIViewControllerTransitioningDelegate>
@property (nonatomic) PKPaymentRequest *paymentRequest;
@end

@interface STPTestPaymentPresentationController : UIPresentationController
@end

@implementation STPTestPaymentAuthorizationViewController

- (instancetype)initWithPaymentRequest:(PKPaymentRequest *)paymentRequest {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    self = [self initWithNibName:nil bundle:bundle];
    if (self) {
        _paymentRequest = paymentRequest;
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    STPTestPaymentSummaryViewController *summary = [[STPTestPaymentSummaryViewController alloc] initWithPaymentRequest:self.paymentRequest];
    summary.delegate = self.delegate;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:summary];
    [self addChildViewController:navController];
    navController.view.frame = self.view.bounds;
    [self.view addSubview:navController.view];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[STPTestPaymentPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end

@implementation STPTestPaymentPresentationController
- (CGRect)frameOfPresentedViewInContainerView {
    CGRect rect = [super frameOfPresentedViewInContainerView];
    rect.origin.y += 30;
    rect.size.height -= 30;
    return rect;
}
@end

