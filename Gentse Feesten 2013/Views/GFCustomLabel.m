//
//  GFCustomLabel.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 1/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFCustomLabel.h"

@implementation GFCustomLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor whiteColor];
        self.shadowColor = [UIColor blackColor];
        self.shadowOffset = CGSizeMake(0, 1);
        self.font = [UIFont fontWithName:@"PT Sans Narrow" size:28.0];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
