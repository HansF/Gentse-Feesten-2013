//
//  GFHomeViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFHomeViewController.h"

#import "NVSlideMenuController.h"

@interface GFHomeViewController ()

@end

@implementation GFHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.leftBarButtonItem = [self showMenuButton];
    }
    return self;
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

- (void)openMenuView:(id)sender {
    if (self.slideMenuController.isMenuOpen) {
        [self.slideMenuController closeMenuAnimated:YES completion:nil];
    }
    else {
        [self.slideMenuController openMenuAnimated:YES completion:nil];
    }
}



@end
