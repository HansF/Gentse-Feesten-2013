//
//  GFNavigationViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFNavigationViewController.h"

#import "GFCustomNavBar.h"

#import "GFHomeViewController.h"

#import "NVSlideMenuController.h"

@interface GFNavigationViewController ()

@property (nonatomic, strong) GFHomeViewController *homeViewController;

@end

@implementation GFNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0x005470);
        [self setValue:[[GFCustomNavBar alloc]init] forKeyPath:@"navigationBar"];

        _homeViewController = [[GFHomeViewController alloc] initWithNibName:nil bundle:NULL];

        [self setViewControllers:[[NSArray alloc] initWithObjects:
                                  _homeViewController,
                                  nil]];

    }
    return self;
}

@end
