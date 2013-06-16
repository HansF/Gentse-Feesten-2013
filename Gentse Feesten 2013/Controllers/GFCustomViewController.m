//
//  GFCustomViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCustomViewController.h"
#import "NVSlideMenuController.h"
#import "GFFavoritesModalViewController.h"
#import "GFFontSmall.h"
#import "GFFont.h"
#import "GFNavigationViewController.h"

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
    self.navigationItem.leftBarButtonItem = [self showMenuButton];
}


-(UITableView *)addTableView {

    UITableView *tableView = [[UITableView alloc] initWithFrame:
                              CGRectMake(padding, 0, self.view.frame.size.width - padding * 2, IS_IOS_7 ? self.view.frame.size.height : self.view.frame.size.height - navBarHeight)];


    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}


-(UIView *)addTableViewHeaderWithTitle:(NSString *)title {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - padding * 2, 60)];
    GFCustomYellowLabel *headerLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width - padding * 2, 28)];
    headerLabel.text = title;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = UIColorFromRGB(0x005470);
    [containerView addSubview:headerLabel];

    UIImage *tableTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *tableTopView = [[UIImageView alloc] initWithImage:tableTop];
    tableTopView.frame = CGRectMake(0, headerLabel.frame.size.height + headerLabel.frame.origin.y + padding, tableTop.size.width, tableTop.size.height);
    [containerView addSubview:tableTopView];

    return containerView;
}


-(UIView *)addTableViewFooter {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - padding * 2, 50)];
    UIImage *tableBottom = [UIImage imageNamed:@"tableBottom.png"];
    UIImageView *tableBottomView = [[UIImageView alloc] initWithImage:tableBottom];
    tableBottomView.frame = CGRectMake(0, 0, tableBottom.size.width, tableBottom.size.height);
    [containerView addSubview:tableBottomView];
    return containerView;
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

    GFFavoritesModalViewController *favoritesViewController = [[GFFavoritesModalViewController alloc] init];
    GFNavigationViewController *navController = [[GFNavigationViewController alloc] initWithRootViewController:favoritesViewController];

    [self presentModalViewController:navController animated:YES];
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

-(void)showAlertNoInternetConnection {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Kan geen verbinding maken met het internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


-(void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)calledFromNavigationController {
    UIImage *buttonImage = [UIImage imageNamed:@"back.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
}


-(GFCustomYellowLabel *)headerLabel:(NSString *)title {
    GFCustomYellowLabel *headerLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(padding, IS_IOS_7 ? 20 + navBarHeight : 20, self.view.frame.size.width - padding * 2, 28)];
    headerLabel.text = title;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = UIColorFromRGB(0x005470);
    return headerLabel;
}

-(CGFloat)getHeightForString:(NSString *)string {
    NSString *text = string;
    CGSize constraint = CGSizeMake(188, 20000.0f);
    CGSize size = [text sizeWithFont:[GFFontSmall sharedInstance] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}

-(CGFloat)getHeightForString:(NSString *)string withWidth:(float)width {
    NSString *text = string;
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [text sizeWithFont:[GFFontSmall sharedInstance] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}

-(CGFloat)getHeightForHeader:(NSString *)string withWidth:(float)width {
    NSString *text = string;
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [text sizeWithFont:[GFFont sharedInstance] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}


@end
