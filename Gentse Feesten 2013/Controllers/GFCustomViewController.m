//
//  GFCustomViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCustomViewController.h"

#import "NVSlideMenuController.h"

#import "GFFavoritesViewController.h"


@interface GFCustomViewController ()

@end

@implementation GFCustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [self showFavoritesButton];
}


- (UIBarButtonItem *)showFavoritesButton {
    UIImage *favButtonImage = [UIImage imageNamed:@"fav.png"];
    UIImage *favButtonImageActive = [UIImage imageNamed:@"fav.png"];
    UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [favButton setBackgroundImage:favButtonImage forState:UIControlStateNormal];
    [favButton setBackgroundImage:favButtonImageActive forState:UIControlStateHighlighted];

    [favButton setFrame:CGRectMake(0, 1, favButtonImage.size.width, favButtonImage.size.height)];

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, favButtonImage.size.width, favButtonImage.size.height)];

    [favButton addTarget:self
                  action:@selector(openFavoritesView:)
        forControlEvents:UIControlEventTouchDown];

    [containerView addSubview:favButton];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}


- (void)openFavoritesView:(id)sender {
    GFFavoritesViewController *favoritesViewController = [[GFFavoritesViewController alloc] init];
    [self presentModalViewController:favoritesViewController animated:YES];
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
