//
//  GFMenu.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 12/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFMenu.h"

@implementation GFMenu

+ (id)sharedInstance {
    static NSArray *__sharedInstance;

    if (__sharedInstance == nil) {
    
        __sharedInstance = [[NSArray alloc] initWithObjects:
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Home", @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_home.png", @"icon",
                             @"home", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Mijn favorieten", @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_favorites.png", @"icon",
                             @"favorites", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Programma", @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_program", @"icon",
                             @"program", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Themakalender", @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"thema", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Gratis", @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"free", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Festivals", @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"festival", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Praktisch", @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"home.png", @"icon",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Publiek sanitair", @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Politie", @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"EHBO", @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Parkings", @"title",
                             [NSNumber numberWithBool:NO], @"bold",
                             @"", @"icon",
                             @"parkings", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Instellingen", @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"home.png", @"icon",
                             @"settings", @"view",
                             nil],
                            [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                             @"Over deze app", @"title",
                             [NSNumber numberWithBool:YES], @"bold",
                             @"menu_about.png", @"icon",
                             @"about", @"view",
                             nil],
                            nil];
    }
    
    return __sharedInstance;
}

@end
