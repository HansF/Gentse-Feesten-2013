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

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(_tableView.frame.origin.x,
                                  _tableView.frame.origin.y + 44,
                                  _tableView.frame.size.width,
                                  _tableView.frame.size.height);
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:[NSLocalizedString(@"MY_FAVORITES", nil) uppercaseString]];
    [_tableView registerClass:[GFCustomEventCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

    GFCustomToolBar *toolbar = [[GFCustomToolBar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
 
    UIImage *closeButtonImage = [UIImage imageNamed:@"close.png"];
    UIImage *closeButtonImageActive = [UIImage imageNamed:@"close.png"];
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [closeButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    [closeButton setBackgroundImage:closeButtonImageActive forState:UIControlStateHighlighted];

    [closeButton setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - (padding / 2) - closeButtonImage.size.width, padding / 2, closeButtonImage.size.width, closeButtonImage.size.height)];

    [closeButton addTarget:self
                   action:@selector(dismissModal:)
         forControlEvents:UIControlEventTouchDown];

    [toolbar addSubview:closeButton];
    
    [self.view addSubview:toolbar];

    self.trackedViewName = @"Favorites";

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

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

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];

    if (indexPath.row < [sectionInfo numberOfObjects]) {
        static NSString *CellIdentifier = @"customCell";
        GFCustomEventCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        GFEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];

        cell.label.text = event.name;

        cell.timeLabel.text = NSLocalizedString(@"ALL_DAY", nill);
        if (event.startuur) {
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

        if ([event.fav isEqualToNumber:[NSNumber numberWithInt:1]]) {
            favButton.selected = YES;
        }
        else {
            favButton.selected = NO;
        }

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
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects] + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
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
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

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
    return 56.0;
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
