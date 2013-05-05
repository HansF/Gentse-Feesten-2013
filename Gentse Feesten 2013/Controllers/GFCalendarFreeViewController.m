//
//  GFCalendarFreeViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCalendarFreeViewController.h"

#import "GFCustomYellowLabel.h"

@interface GFCalendarFreeViewController ()

@end

@implementation GFCalendarFreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        GFCustomYellowLabel *headerLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width - padding * 2, 28)];
        headerLabel.text = @"GRATIS";
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.backgroundColor = UIColorFromRGB(0x005470);
        [self.view addSubview:headerLabel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	if (_calledFromNavigationController == YES) {
        self.navigationItem.leftBarButtonItem = [super showMenuButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
