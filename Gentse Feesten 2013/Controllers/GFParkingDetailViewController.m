//
//  GFParkingDetailViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 11/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "GFParkingDetailViewController.h"

#import "MDCParallaxView.h"

@interface GFParkingDetailViewController () <UIScrollViewDelegate, MKMapViewDelegate>

@end

@implementation GFParkingDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 480)];

    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];

    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = 22.569722 ;
    region.center.longitude = 88.369722;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [mapView setRegion:region animated:YES];

    [mapView setDelegate:self];

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 600)];
    containerView.backgroundColor = UIColorFromRGB(0x005470);

    MDCParallaxView *parallaxView = [[MDCParallaxView alloc] initWithBackgroundView:mapView
                                                                     foregroundView:containerView];
    parallaxView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    parallaxView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    parallaxView.backgroundHeight = 140.0f;
    parallaxView.scrollView.scrollsToTop = YES;
    parallaxView.scrollViewDelegate = self;
    [self.view addSubview:parallaxView];

    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
