//
//  GFFavoritesModalViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GFFavoritesModalViewController.h"
#import "GFCustomEventCell.h"
#import "GFFontSmall.h"
#import "GFEventsDataModel.h"
#import "GFEvent.h"
#import "GFCustomToolBar.h"
#import "GFDates.h"
#import "GFEventDetailViewController.h"

@interface GFFavoritesModalViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GFFavoritesModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0x005470);
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.fetchedResultsController performFetch:nil];
    [_tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:[NSLocalizedString(@"MY_FAVORITES", nil) uppercaseString]];
    [_tableView registerClass:[GFCustomEventCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];
 
    UIImage *menuButtonImage = [UIImage imageNamed:@"close.png"];
    UIImage *menuButtonImageActive = [UIImage imageNamed:@"close.png"];
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [menuButton setBackgroundImage:menuButtonImage forState:UIControlStateNormal];
    [menuButton setBackgroundImage:menuButtonImageActive forState:UIControlStateHighlighted];

    [menuButton setFrame:CGRectMake(0, 0, menuButtonImage.size.width, menuButtonImage.size.height)];

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, menuButtonImage.size.width, menuButtonImage.size.height)];

    [menuButton addTarget:self
                   action:@selector(dismissModal:)
         forControlEvents:UIControlEventTouchDown];

    [containerView addSubview:menuButton];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.leftBarButtonItem = nil;

    self.trackedViewName = @"Favorites";

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([[self.fetchedResultsController sections] count] == 0) {
        return [super getHeightForString:NSLocalizedString(@"NO_FAVORITES_YET", nil)] + 30 + 1;
    }

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];
    if (indexPath.row < [sectionInfo numberOfObjects]) {
        GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
        return [super getHeightForString:event.name] + 30 + 1;
    }
    else {
        return 25;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.fetchedResultsController sections] count] == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding * 2, 0, self.view.frame.size.width - padding * 4, 55)];
        label.font = [GFFontSmall sharedInstance];
        label.textColor = [UIColor darkGrayColor];
        label.highlightedTextColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"NO_FAVORITES_YET", nil);
        [cell.contentView addSubview:label];

        UIView *footer = [super addTableViewFooter];
        footer.frame = CGRectMake(0, label.frame.origin.y + label.frame.size.height, footer.frame.size.width, 15);
        [cell.contentView addSubview:footer];

        UIView *myBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, footer.frame.size.width, 15)];
        myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
        cell.backgroundView = myBackView;

        return cell;
    }

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];

    if (indexPath.row < [sectionInfo numberOfObjects]) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomEventCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];

        cell.label.text = event.name;

        if ([event.sort isEqualToNumber:[NSNumber numberWithInt:0]]) {
            cell.timeLabel.text = NSLocalizedString(@"ALL_DAY", nil);
        }
        else {
            cell.timeLabel.text = event.startuur;
        }

        CGFloat height = [super getHeightForString:event.name];

        cell.label.frame = CGRectMake(55, cell.label.frame.origin.y, 188, height + 30);

        cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);

        cell.containerView.frame = CGRectMake(padding, 0, [[UIScreen mainScreen] bounds].size.width - (padding * 4) - 2, height + 30);

        cell.bottomBorder.frame = CGRectMake(0, height + 30, cell.containerView.frame.size.width, 1);

        UIImage *favButtonImage = [UIImage imageNamed:@"fav_off.png"];
        UIImage *favButtonImageActive = [UIImage imageNamed:@"fav_on.png"];
        UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];

        favButton.selected = YES;
        
        [favButton setBackgroundImage:favButtonImage forState:UIControlStateNormal];
        [favButton setBackgroundImage:favButtonImageActive forState:UIControlStateSelected];

        [favButton setFrame:CGRectMake(245, 0, favButtonImage.size.width, favButtonImage.size.height)];
        [favButton addTarget:self
                      action:@selector(addEventToFavorites:)
            forControlEvents:UIControlEventTouchDown];
        [cell.containerView addSubview:favButton];

        return cell;
    }
    else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        UIView *footer = [super addTableViewFooter];
        footer.frame = CGRectMake(0, 10, footer.frame.size.width, 15);
        [cell.contentView addSubview:footer];

        UIView *myBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, footer.frame.size.width, 15)];
        myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
        cell.backgroundView = myBackView;

        return cell;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.fetchedResultsController sections] count] == 0) {
        return 1;
    }
    else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
        return [sectionInfo numberOfObjects] + 1;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[self.fetchedResultsController sections] count] == 0) {
        return 1;
    }
    else {
        return [[self.fetchedResultsController sections] count];
    }

}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }


    NSManagedObjectContext *context = [[GFEventsDataModel sharedDataModel] mainContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [GFEvent entityInManagedObjectContext:context];

    [fetchRequest setEntity:entity];

    [fetchRequest setReturnsObjectsAsFaults:NO];

    [fetchRequest setFetchBatchSize:20];

    NSSortDescriptor *datumSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datum" ascending:YES];
    NSSortDescriptor *sortSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort" ascending:YES];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:datumSortDescriptor, sortSortDescriptor, nil];

    [fetchRequest setSortDescriptors:sortDescriptors];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fav == 1"];
    fetchRequest.predicate = predicate;

    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:@"datum" cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;

	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        abort();
	}

    return _fetchedResultsController;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    GFEventDetailViewController *detail = [[GFEventDetailViewController alloc] initWithNibName:nil bundle:NULL];
    GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    detail.event = event;
    detail.calledFromNavigationController = YES;
    detail.calledFromFavoritesModalController = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if ([[self.fetchedResultsController sections] count] == 0) {
        return nil;
    }

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(padding, 0, [[UIScreen mainScreen] bounds].size.width - (padding * 4) - 2, 55)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, headerView.frame.size.width - (padding * 2), 55)];
    label.font = [GFFontSmall sharedInstance];
    label.textColor = UIColorFromRGB(0x002d46);
    label.backgroundColor = [UIColor whiteColor];

    for (id date in [GFDates sharedInstance]) {
        if ([[date objectForKey:@"id"] isEqualToString:[sectionInfo name]]) {
            label.text = [[date objectForKey:@"name"] uppercaseString];
        }
    }

    label.textAlignment = UITextAlignmentCenter;
    [headerView addSubview:label];

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(padding, 55, headerView.frame.size.width, 1);
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;
    [headerView.layer addSublayer:bottomBorder];

    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
    
    return headerView;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[self.fetchedResultsController sections] count] == 0) {
        return 0;
    }
    else {
        return 56.0;
    }
}

- (void)dismissModal:(id)button
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)addEventToFavorites:(UIButton*)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {

        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:[[GFEventsDataModel sharedDataModel] persistentStoreCoordinator]];

        NSInteger serverId = [[[self.fetchedResultsController objectAtIndexPath:indexPath] serverId] intValue];
        GFEvent *event = [GFEvent eventWithServerId:serverId usingManagedObjectContext:context];
        bool status;
        if ([event.fav isEqualToNumber:[NSNumber numberWithInt:1]]) {
            status = NO;
        }
        else {
            status = YES;
        }
        sender.selected = status;
        [event toggleFavorite:status];
        [[self.fetchedResultsController objectAtIndexPath:indexPath] toggleFavorite:status];
        [context save:nil];
        [self.fetchedResultsController performFetch:nil];
        [_tableView reloadData];
        
    }
}


@end
