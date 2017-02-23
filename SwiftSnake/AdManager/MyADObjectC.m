//
//  MyADObjectC.m
//  Snake 1998
//
//  Created by Phuong Nguyen on 2/23/17.
//  Copyright © 2017 Phuong Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyADObjectC.h"


@implementation MyADObjectC : NSObject

UIViewController *viewController;//


- (void)viewDidLoad:(UIViewController*) view {
    viewController = view;
    
    
    
    
    viewController.view.backgroundColor = [UIColor whiteColor];
    ADCBannerView *bannerView = [[ADCBannerView alloc] initWithZoneID:@"1526879" onViewController:self];
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [viewController.view addSubview:bannerView];
    NSDictionary *views = NSDictionaryOfVariableBindings(bannerView);
    
    [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bannerView]|" options:0 metrics:nil views:views]];
    
    [viewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bannerView]|" options:0 metrics:nil views:views]];
    
    bannerView.delegate = self;
    
    [bannerView load];
}



#pragma mark - Adcash Banner Delegate Methods
-(void)bannerViewDidReceiveAd:(ADCBannerView *)bannerView {
    NSLog(@"Banner loaded.");
}

-(void)bannerView:(ADCBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Banner failed to load. Error: %@",[error localizedDescription]);
}

-(void)bannerViewWillPresentScreen:(ADCBannerView *)bannerView {
    NSLog(@"Banner will present screen.");
}

-(void)bannerViewWillDismissScreen:(ADCBannerView *)bannerView {
    NSLog(@"Banner will dismiss screen.");
}

-(void)bannerViewWillLeaveApplication:(ADCBannerView *)bannerView {
    NSLog(@"Banner will leave application.");
}

@end