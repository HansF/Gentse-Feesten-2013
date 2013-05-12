//
//  GFFavoritesModalViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFFavoritesModalViewController.h"

#import "GFCustomToolBar.h"

@interface GFFavoritesModalViewController ()

@end

@implementation GFFavoritesModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    GFCustomToolBar *toolbar = [[GFCustomToolBar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissModal:)];

    [items addObject:item];
    [toolbar setItems:items animated:NO];
    [self.view addSubview:toolbar];

    self.trackedViewName = @"Favorites";

}


- (void)dismissModal:(id)button
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
