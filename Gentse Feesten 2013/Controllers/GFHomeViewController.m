//
//  GFHomeViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GFHomeViewController.h"
#import "GFCustomCell.h"

@interface GFHomeViewController ()

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

    _tableView = [super addTableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [super addTableViewHeaderWithTitle:@"HOME"];
    [_tableView registerClass:[GFCustomCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];

    self.trackedViewName = @"Home";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"customCell";
    GFCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.label.text = @"ahah";
    cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [super addTableViewFooter];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
