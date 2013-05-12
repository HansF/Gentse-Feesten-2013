//
//  GFParkingListViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 11/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GFParkingListViewController.h"
#import "GFAPIClient.h"
#import "AFNetworking.h"
#import "GFParkingDetailViewController.h"
#import "GFParkingsCustomCell.h"

@interface GFParkingListViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *responseData;

@end

@implementation GFParkingListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad {

    [super viewDidLoad];

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:@"HOME"];
    [_tableView registerClass:[GFParkingsCustomCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

    [[GFAPIClient sharedInstance] getPath:@"Mobiliteitsbedrijf/Parkings11.json" parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id response) {

                                      _responseData = [NSMutableArray array];
                                      for (id parking in [[response objectForKey:@"Parkings11"] objectForKey:@"parkings"]) {
                                          [_responseData addObject:parking];
                                      }
                                      [self.tableView reloadData];
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                                      [super showAlertNoInternetConnection];
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                  }];

    self.trackedViewName = @"Parkings";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _responseData.count > 0 ? _responseData.count : 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    GFParkingsCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.label.text = [[_responseData objectAtIndex:indexPath.row] objectForKey:@"description"];
    cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);
    cell.count.text = [[_responseData objectAtIndex:indexPath.row] objectForKey:@"availableCapacity"];
    if ([[[_responseData objectAtIndex:indexPath.row] objectForKey:@"availableCapacity"] isEqual: @"VOL"]) {
        cell.count.textColor = UIColorFromRGB(0xe64a45);
    }
    else {
        cell.count.textColor = [UIColor greenColor];
    }
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [super addTableViewFooter];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    GFParkingDetailViewController *detail = [[GFParkingDetailViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
