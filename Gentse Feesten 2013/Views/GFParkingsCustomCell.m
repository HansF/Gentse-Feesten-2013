//
//  GFParkingsCustomCell.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 12/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFParkingsCustomCell.h"

@implementation GFParkingsCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setCountView];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (void)setCountView {
    _count = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 70, 55)];
    _count.font = [UIFont fontWithName:@"PTSans-Narrow" size:20.0];
    _count.backgroundColor = [UIColor clearColor];
    _count.highlightedTextColor = [UIColor whiteColor];
    _count.textAlignment = UITextAlignmentRight;
    [super.containerView addSubview:_count];
}

@end
