//
//  GFFavoritesViewController.m
//  #GF13
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFFavoritesViewController.h"

#import "GFCustomYellowLabel.h"

@interface GFFavoritesViewController ()

@end

@implementation GFFavoritesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        GFCustomYellowLabel *headerLabel = [[GFCustomYellowLabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width - padding * 2, 28)];
        headerLabel.text = @"FAVORIETEN";
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.backgroundColor = UIColorFromRGB(0x005470);
        [self.view addSubview:headerLabel];
    }
    return self;
}

-(void)viewDidLoad {

    [super viewDidLoad];

    self.trackedViewName = @"Favorites";
    
}

@end
