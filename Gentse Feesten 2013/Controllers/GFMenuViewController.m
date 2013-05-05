//
//  GFMenuViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFMenuViewController.h"

#import "NVSlideMenuController.h"

#import "GFCustomToolBar.h"

#import "GFCustomViewController.h"

#import "GFPoiMapViewController.h"

#import "GFHomeViewController.h"

#import "GFNavigationViewController.h"

#import "GFAboutViewController.h"

#import "GFSettingsViewController.h"

@interface GFMenuViewController() <UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UISearchDisplayController *searchController;

@property (nonatomic, strong) UITableView *menuTableView;

@property (nonatomic, strong) NSArray *menu;

@end

@implementation GFMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupSearchBar];
        [self setupTableView];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupMenu];

}

- (void)setupMenu {

    _menu = [[NSArray alloc] initWithObjects:
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Home", @"title",
              [NSNumber numberWithBool:YES], @"bold",
              @"home.png", @"icon",
              @"home", @"view",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Mijn favorieten", @"title",
              [NSNumber numberWithBool:YES], @"bold",
              @"home.png", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Programma", @"title",
              [NSNumber numberWithBool:YES], @"bold",
              @"home.png", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Themakalender", @"title",
              [NSNumber numberWithBool:NO], @"bold",
              @"", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Gratis", @"title",
              [NSNumber numberWithBool:NO], @"bold",
              @"", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Festivals", @"title",
              [NSNumber numberWithBool:NO], @"bold",
              @"", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Praktisch", @"title",
              [NSNumber numberWithBool:YES], @"bold",
              @"home.png", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Publiek sanitair", @"title",
              [NSNumber numberWithBool:NO], @"bold",
              @"", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Politie", @"title",
              [NSNumber numberWithBool:NO], @"bold",
              @"", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"EHBO", @"title",
              [NSNumber numberWithBool:NO], @"bold",
              @"", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Parkings", @"title",
              [NSNumber numberWithBool:NO], @"bold",
              @"", @"icon",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Instellingen", @"title",
              [NSNumber numberWithBool:YES], @"bold",
              @"home.png", @"icon",
              @"settings", @"view",
              nil],
             [[NSMutableDictionary alloc] initWithObjectsAndKeys:
              @"Over deze app", @"title",
              [NSNumber numberWithBool:YES], @"bold",
              @"home.png", @"icon",
              @"about", @"view",
              nil],
             nil];

    [_menuTableView reloadData];
}


- (void)setupSearchBar {

    GFCustomToolBar *toolbar = [[GFCustomToolBar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 60, navBarHeight)];

    [[_searchBar.subviews objectAtIndex:0] removeFromSuperview];
    [_searchBar setBackgroundColor:[UIColor clearColor]];

    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchController.searchResultsDataSource = self;
    _searchController.searchResultsDelegate = self;
    _searchController.delegate = self;

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 60, navBarHeight)];
    [containerView addSubview:_searchBar];

    [toolbar addSubview:containerView];

    [self.view addSubview:toolbar];
    
    
}


- (void)setupTableView {
    _menuTableView = [[UITableView alloc] initWithFrame:
                  CGRectMake(0, navBarHeight, self.view.frame.size.width - padding * 2, self.view.frame.size.height - navBarHeight)];
    
    _menuTableView.backgroundColor = [UIColor clearColor];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.separatorColor = UIColorFromRGB(0x174e61);
    _menuTableView.backgroundColor = UIColorFromRGB(0x12414f);
    [self.view addSubview:_menuTableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _menuTableView) {
        return _menu.count;
    }
    else {
        return 0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifer = @"cell";

    UITableViewCell *cell = [_menuTableView dequeueReusableCellWithIdentifier:cellIdentifer];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }

    if (tableView == _menuTableView) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width - 50, 38)];

        title.textColor = UIColorFromRGB(0x7eb5c2);
        title.shadowColor = [UIColor blackColor];
        title.shadowOffset = CGSizeMake(0, 1);
        if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"bold"] integerValue] == 1) {
            title.font = [UIFont fontWithName:@"PTSans-NarrowBold" size:20.0];
        }
        else {
            title.font = [UIFont fontWithName:@"PTSans-Narrow" size:20.0];
            UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
            myBackView.backgroundColor = UIColorFromRGB(0x0e3845);
            cell.backgroundView = myBackView;
        }
        title.backgroundColor = [UIColor clearColor];
        title.highlightedTextColor = [UIColor whiteColor];
        [title setText:[[_menu objectAtIndex:indexPath.row] objectForKey:@"title"]];
        [cell.contentView addSubview:title];

        cell.accessoryType = UITableViewCellAccessoryNone;

        UIView *mySelectedBackView = [[UIView alloc] initWithFrame:cell.frame];
        mySelectedBackView.backgroundColor = UIColorFromRGB(0xe64a45);
        cell.selectedBackgroundView = mySelectedBackView;

        if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"icon"] length] != 0) {
            UIImage *image = [UIImage imageNamed:[[_menu objectAtIndex:indexPath.row] objectForKey:@"icon"]];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (38 - image.size.height) / 2 , image.size.width, image.size.height)];
            [imgView setImage:image];
            
            imgView.tag = 1;
            [cell.contentView addSubview:imgView];
        }
    }
    else {

    }


    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_menuTableView deselectRowAtIndexPath:indexPath animated:YES];

    GFNavigationViewController *navigationViewController = [[GFNavigationViewController alloc] initWithNibName:nil bundle:NULL];

    if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"home"]) {
        GFHomeViewController *detailViewController = [[GFHomeViewController alloc] initWithNibName:nil bundle:nil];
        [navigationViewController setViewControllers:[[NSArray alloc] initWithObjects:
                                                      detailViewController,
                                                      nil]];

    }
    else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"about"]) {
        GFAboutViewController *detailViewController = [[GFAboutViewController alloc] initWithNibName:nil bundle:nil];
        [navigationViewController setViewControllers:[[NSArray alloc] initWithObjects:
                                                      detailViewController,
                                                      nil]];

    }
    else if ([[[_menu objectAtIndex:indexPath.row] objectForKey:@"view"] isEqual: @"settings"]) {
        GFSettingsViewController *detailViewController = [[GFSettingsViewController alloc] initWithNibName:nil bundle:nil];
        [navigationViewController setViewControllers:[[NSArray alloc] initWithObjects:
                                                      detailViewController,
                                                      nil]];

    }
    else {
        GFPoiMapViewController *detailViewController = [[GFPoiMapViewController alloc] initWithNibName:nil bundle:nil];
        [navigationViewController setViewControllers:[[NSArray alloc] initWithObjects:
                                                      detailViewController,
                                                      nil]];

    }
    
    [self.slideMenuController closeMenuBehindContentViewController:navigationViewController animated:YES completion:nil];
}

@end
