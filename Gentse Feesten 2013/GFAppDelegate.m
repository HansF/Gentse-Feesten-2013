//
//  GFAppDelegate.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 30/04/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFAppDelegate.h"

#import "SDURLCache.h"

#import "NVSlideMenuController.h"

#import "GFHomeViewController.h"

#import "GFEventsDataModel.h"

@interface GFAppDelegate()

@end

@implementation GFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    GFNavigationViewController *navigationViewController = [[GFNavigationViewController alloc] initWithNibName:nil bundle:NULL];

    GFHomeViewController *homeViewController = [[GFHomeViewController alloc] initWithNibName:nil bundle:NULL];

    [navigationViewController setViewControllers:[[NSArray alloc] initWithObjects:
                              homeViewController,
                              nil]];

    _menuViewController = [[GFMenuViewController alloc] initWithNibName:nil bundle:NULL];

    NVSlideMenuController *slideMenuVC = [[NVSlideMenuController alloc] initWithMenuViewController:_menuViewController
                                                                          andContentViewController:navigationViewController];

	self.window.rootViewController = slideMenuVC;

    NSManagedObjectContext *context = [[GFEventsDataModel sharedDataModel] mainContext];
    if (context) {
        NSLog(@"Context is ready!");


//        [context save:nil];
    } else {
        NSLog(@"Context was nil :(");
    }

    [GAI sharedInstance].trackUncaughtExceptions = NO;
    [GAI sharedInstance].dispatchInterval = 10;
    [GAI sharedInstance].debug = NO;
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-40824609-1"];
    
    return YES;
}

- (void)prepareCache {
    SDURLCache *cache = [[SDURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                      diskCapacity:20 * 1024 * 1024
                                                          diskPath:[SDURLCache defaultCachePath]];
    cache.minCacheInterval = 0;
    [NSURLCache setSharedURLCache:cache];
}

@end
