//
//  GFPoiMapViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 4/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFPoiMapViewController.h"

#import "GFCustomToolBar.h"

@implementation GFPoiMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = [super showMenuButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - navBarHeight)];

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

    [self.view addSubview:mapView];
    
}


- (UIBarButtonItem *)showMenuButton {

    UIImage *menuButtonImage = [UIImage imageNamed:@"list.png"];
    UIImage *menuButtonImageActive = [UIImage imageNamed:@"list.png"];
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [menuButton setBackgroundImage:menuButtonImage forState:UIControlStateNormal];
    [menuButton setBackgroundImage:menuButtonImageActive forState:UIControlStateHighlighted];

    [menuButton setFrame:CGRectMake(0, 0, menuButtonImage.size.width, menuButtonImage.size.height)];

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, menuButtonImage.size.width, menuButtonImage.size.height)];

    [menuButton addTarget:self
                   action:@selector(openMenuView:)
         forControlEvents:UIControlEventTouchDown];

    [containerView addSubview:menuButton];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}


@end
