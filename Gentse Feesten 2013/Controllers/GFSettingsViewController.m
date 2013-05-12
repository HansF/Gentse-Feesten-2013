//
//  GFSettingsViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFSettingsViewController.h"

@interface GFSettingsViewController ()

@end

@implementation GFSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view addSubview:[super headerLabel:@"INSTELLINGEN"]];
    }
    return self;
}

-(void)viewDidLoad {

    [super viewDidLoad];

    self.trackedViewName = @"Settings";
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
