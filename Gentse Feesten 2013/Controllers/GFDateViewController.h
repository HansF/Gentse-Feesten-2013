//
//  GFDateViewController.h
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 31/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFCustomViewController.h"

@interface GFDateViewController : GFCustomViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) BOOL calledFromNavigationController;

@end
