//
//  GFHomeViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GFHomeViewController.h"
#import "GFCustomEventCell.h"
#import "GFEventsDataModel.h"
#import "GFEvent.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "GFAPIClient.h"
#import "GFFontSmall.h"

@interface GFHomeViewController () {
    MBProgressHUD *_hud;
}


@property (nonatomic, strong) UITableView *tableView;


@end

@implementation GFHomeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];

    if ([self numberOfEvents] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"PROGRAM", nil) message:NSLocalizedString(@"NO_EVENTS_YET", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"CANCEL", nil) otherButtonTitles:nil];
        [alert addButtonWithTitle:NSLocalizedString(@"DOWNLOAD", nil)];
        [alert show];
    }

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - padding * 2, 60)];
    
    UIImage *stuntDude = [UIImage imageNamed:@"stunt-dude.png"];
    UIImageView *stuntDudeView = [[UIImageView alloc] initWithImage:stuntDude];
    [containerView addSubview:stuntDudeView];

    UIImage *tableTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *tableTopView = [[UIImageView alloc] initWithImage:tableTop];
    tableTopView.frame = CGRectMake(0, stuntDudeView.frame.size.height + stuntDudeView.frame.origin.y, tableTop.size.width, tableTop.size.height);
    [containerView addSubview:tableTopView];

    containerView.frame = CGRectMake(containerView.frame.origin.x, containerView.frame.origin.y, containerView.frame.size.width, tableTopView.frame.size.height + tableTopView.frame.origin.y);

    _tableView.tableHeaderView = containerView;

    [_tableView registerClass:[GFCustomEventCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

    self.trackedViewName = @"Home";

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

    [fetchRequest setFetchLimit:10];
       
    NSSortDescriptor *datumSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datum" ascending:YES];
    NSSortDescriptor *sortSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort" ascending:YES];

    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:datumSortDescriptor, sortSortDescriptor, nil];

    [fetchRequest setSortDescriptors:sortDescriptors];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"serverId IN %@", [GFEvent getRandomAmountServerIds:10 UsingManagedObjectContext:context]];

    fetchRequest.predicate = predicate;

    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
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

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(padding, 0, [[UIScreen mainScreen] bounds].size.width - (padding * 4) - 2, 55)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, headerView.frame.size.width - (padding * 2), 55)];
    label.font = [GFFontSmall sharedInstance];
    label.textColor = UIColorFromRGB(0x002d46);
    label.backgroundColor = [UIColor whiteColor];

    
    label.text = [[NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"SPOTLIGHT", nil), NSLocalizedString(@"ZATERDAG_20_JULI", nil)] uppercaseString];

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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index
{
    if (index == 1) {
        [self updateProgram];
    }
}

-(void)updateProgram {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }

    [_hud setMode:MBProgressHUDModeIndeterminate];
    [_hud setLabelText:@"Fetching..."];
    [self.view addSubview:_hud];

    [[GFAPIClient sharedInstance] getPath:@"events/list.json" parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id response) {
                                      [self parseEvents:response];
                                      [_tableView reloadData];
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      [super showAlertNoInternetConnection];
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                      [_hud show:NO];
                                  }];

    [_hud show:YES];
    _hud.dimBackground = YES;
}

- (void)parseEvents:(id)events {
    [_hud setMode:MBProgressHUDModeDeterminate];
    [_hud setProgress:0];
    [_hud setLabelText:NSLocalizedString(@"IMPORTING", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSInteger totalRecords = [events count];
        NSInteger currentRecord = 0;

        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:[[GFEventsDataModel sharedDataModel] persistentStoreCoordinator]];

        for (NSDictionary *dictionary in events) {
            NSInteger serverId = [[dictionary objectForKey:@"id"] intValue];
            GFEvent *event = [GFEvent eventWithServerId:serverId usingManagedObjectContext:context];
            if (event == nil) {
                event = [GFEvent insertInManagedObjectContext:context];
                [event setServerId:[NSNumber numberWithInteger:serverId]];
            }

            [event updateAttributes:dictionary];

            currentRecord++;

            dispatch_async(dispatch_get_main_queue(), ^{
                float percent = ((float)currentRecord) / totalRecords;
                [_hud setProgress:percent];
            });
        }

        NSError *error = nil;
        if ([context save:&error]) {
            dispatch_async(dispatch_get_main_queue(), ^{

                [_hud setLabelText:NSLocalizedString(@"DONE", nil)];
                _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                _hud.mode = MBProgressHUDModeCustomView;
                [_hud hide:YES afterDelay:2.0];
            });
        } else {
            NSLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
            exit(1);
        }
    });
}


- (int)numberOfEvents {
    NSManagedObjectContext *context = [[GFEventsDataModel sharedDataModel] mainContext];
    return [GFEvent countWithManagedObjectContext:context];
}


@end
