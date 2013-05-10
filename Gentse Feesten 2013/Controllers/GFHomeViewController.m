//
//  GFHomeViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GFHomeViewController.h"

#import "GFCustomLabel.h"

#import "GFCustomYellowLabel.h"

@interface GFHomeViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GFHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.navigationItem.leftBarButtonItem = [super showMenuButton];

        [self addTableView];

        [self addTableViewHeader];
        
        [self.view addSubview:_tableView];
        
    }
    return self;
}


- (void)addTableView {
    _tableView = [[UITableView alloc] initWithFrame:
                  CGRectMake(padding, 0, self.view.frame.size.width - padding * 2, self.view.frame.size.height - navBarHeight)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)addTableViewHeader {
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - padding * 2, 60)];
    GFCustomYellowLabel *headerLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width - padding * 2, 28)];
    headerLabel.text = @"HOME";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = UIColorFromRGB(0x005470);
    [containerView addSubview:headerLabel];

    UIImage *tableTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *tableTopView = [[UIImageView alloc] initWithImage:tableTop];
    tableTopView.frame = CGRectMake(0, headerLabel.frame.size.height + headerLabel.frame.origin.y + padding, tableTop.size.width, tableTop.size.height);
    [containerView addSubview:tableTopView];

    _tableView.tableHeaderView = containerView;
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

    static NSString *cellIdentifer = @"cell";

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifer];

    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];

        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(padding, 0, self.view.frame.size.width - 2 - (padding * 4), 55)];
        containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);

        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, self.view.frame.size.width - 2 - (padding * 6), 55)];
        title.font = [UIFont fontWithName:@"PTSans-Narrow" size:20.0];
        title.textColor = [UIColor darkGrayColor];
        title.highlightedTextColor = [UIColor whiteColor];
        [title setText:@"Titel 1"];
        title.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : UIColorFromRGB(0xf5f5f5);

        [containerView addSubview:title];

        CALayer *bottomBorder = [CALayer layer];

        bottomBorder.frame = CGRectMake(0, 55, containerView.frame.size.width, 1);

        bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                         alpha:1.0f].CGColor;

        [containerView.layer addSublayer:bottomBorder];

        [cell.contentView addSubview:containerView];

        cell.accessoryType = UITableViewCellAccessoryNone;

        UIImage *backgroundImage = [UIImage imageNamed:@"cellbackground.png"];

        UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
        myBackView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        cell.backgroundView = myBackView;

        UIView *mySelectedBackView = [[UIView alloc] initWithFrame:CGRectMake(padding * 2, 0, cell.frame.size.width - (padding * 2), cell.frame.size.height)];
        mySelectedBackView.backgroundColor = UIColorFromRGB(0xe64a45);
        cell.selectedBackgroundView = mySelectedBackView;

    }

    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - padding * 2, 50)];

    UIImage *tableBottom = [UIImage imageNamed:@"tableBottom.png"];
    UIImageView *tableBottomView = [[UIImageView alloc] initWithImage:tableBottom];
    tableBottomView.frame = CGRectMake(0, 0, tableBottom.size.width, tableBottom.size.height);
    [containerView addSubview:tableBottomView];

    GFCustomLabel *headerLabel = [[GFCustomLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width - padding * 2, 45)];
    headerLabel.text = @"GA NAAR DE KORENMARKT";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.backgroundColor = UIColorFromRGB(0xed4e40);
    headerLabel.font = [UIFont fontWithName:@"PT Sans Narrow" size:20.0];
    [containerView addSubview:headerLabel];
    

    return containerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
}



@end
