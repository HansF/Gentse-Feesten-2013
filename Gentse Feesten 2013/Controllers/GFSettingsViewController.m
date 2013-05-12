//
//  GFSettingsViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFSettingsViewController.h"

#import "GFCustomYellowLabel.h"

@interface GFSettingsViewController ()

@end

@implementation GFSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        GFCustomYellowLabel *headerLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width - padding * 2, 28)];
        headerLabel.text = @"INSTELLINGEN";
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.backgroundColor = UIColorFromRGB(0x005470);
        [self.view addSubview:headerLabel];

        self.navigationItem.leftBarButtonItem = [super showMenuButton];
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
