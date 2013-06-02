//
//  GFDates.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 31/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFDates.h"

@implementation GFDates

+ (id)sharedInstance {
    static NSArray *__sharedInstance;

    if (__sharedInstance == nil) {

        __sharedInstance = [[NSArray alloc] initWithObjects:
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374271200", @"id",
                             NSLocalizedString(@"ZATERDAG_20_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374357600", @"id",
                             NSLocalizedString(@"ZONDAG_21_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374444000", @"id",
                             NSLocalizedString(@"MAANDAG_22_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374530400", @"id",
                             NSLocalizedString(@"DINSDAG_23_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374616800", @"id",
                             NSLocalizedString(@"WOENSDAG_24_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374703200", @"id",
                             NSLocalizedString(@"DONDERDAG_25_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374789600", @"id",
                             NSLocalizedString(@"VRIJDAG_26_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374876000", @"id",
                             NSLocalizedString(@"ZATERDAG_27_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1374962400", @"id",
                             NSLocalizedString(@"ZONDAG_28_JULI", nil), @"name",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"1375048800", @"id",
                             NSLocalizedString(@"MAANDAG_29_JULI", nil), @"name",
                             nil],
                            nil];
    }

    return __sharedInstance;
}

@end
