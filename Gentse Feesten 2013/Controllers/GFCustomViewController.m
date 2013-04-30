//
//  GFCustomViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCustomViewController.h"

#import "GFFavoritesViewController.h"

@interface GFCustomViewController ()

@property (nonatomic, strong) GFFavoritesViewController *favoritesViewController;

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

    [favButton setFrame:CGRectMake(0, 0, favButtonImage.size.width, favButtonImage.size.height)];

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, favButtonImage.size.width, favButtonImage.size.height)];

    [favButton addTarget:self
                  action:@selector(openFavoritesView:)
        forControlEvents:UIControlEventTouchDown];

    [containerView addSubview:favButton];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}


- (void)openFavoritesView:(id)sender {
    _favoritesViewController = [[GFFavoritesViewController alloc] init];
    [self presentModalViewController:_favoritesViewController animated:YES];
}

@end
