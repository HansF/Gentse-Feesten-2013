//
//  GFCalendarCategoryViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCalendarCategoryViewController.h"

@interface GFCalendarCategoryViewController ()

@end

@implementation GFCalendarCategoryViewController

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

    [self.view addSubview:[super headerLabel:@"THEMAKALENDER"]];

    if (_calledFromNavigationController == YES) {
        [super calledFromNavigationController];
    }

    self.trackedViewName = @"Program by category";
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
