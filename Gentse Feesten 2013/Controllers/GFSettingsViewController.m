//
//  GFSettingsViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "GFSettingsViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "GFEventsDataModel.h"
#import "GFEvent.h"
#import "GFAPIClient.h"

@interface GFSettingsViewController () {
    MBProgressHUD *_hud;
}
@end

@implementation GFSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view addSubview:[super headerLabel:[NSLocalizedString(@"SETTINGS", nil) uppercaseString]]];
    }
    return self;
}

-(void)viewDidLoad {

    [super viewDidLoad];

    self.trackedViewName = @"Settings";

    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateButton addTarget:self
                    action:@selector(updateProgram)
          forControlEvents:UIControlEventTouchDown];
    [updateButton setTitle:[NSLocalizedString(@"UPDATE_PROGRAM", nil) uppercaseString] forState:UIControlStateNormal];
    updateButton.frame = CGRectMake(padding, 100, self.view.frame.size.width - (padding * 2), 55.0);
    updateButton.backgroundColor = UIColorFromRGB(0xed4e40);

    updateButton.layer.masksToBounds = NO;
    updateButton.layer.shadowColor = UIColorFromRGB(0x043c4b).CGColor;
    updateButton.layer.shadowOpacity = 1;
    updateButton.layer.shadowRadius = 0;
    updateButton.layer.shadowOffset = CGSizeMake(2.0f, 3.0f);

    [self.view addSubview:updateButton];

}


-(void)updateProgram {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }

    [_hud setMode:MBProgressHUDModeIndeterminate];
    [_hud setLabelText:NSLocalizedString(@"FETCHING", nil)];
    [self.view addSubview:_hud];
    
    [[GFAPIClient sharedInstance] getPath:@"events/list.json" parameters:nil
                                          success:^(AFHTTPRequestOperation *operation, id response) {
                                              [self parseEvents:response];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              [super showAlertNoInternetConnection];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              [_hud show:NO];
                                          }];

    [_hud show:YES];
    _hud.dimBackground = YES;
}

- (void)parseEvents:(id)events {
    [_hud setMode:MBProgressHUDModeDeterminate];
    [_hud setProgress:0];
    [_hud setLabelText:NSLocalizedString(@"IMPORTING", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSInteger totalRecords = [events count];
        NSInteger currentRecord = 0;

        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:[[GFEventsDataModel sharedDataModel] persistentStoreCoordinator]];

        for (NSDictionary *dictionary in events) {
            NSInteger serverId = [[dictionary objectForKey:@"id"] intValue];
            GFEvent *event = [GFEvent eventWithServerId:serverId usingManagedObjectContext:context];
            if (event == nil) {
                event = [GFEvent insertInManagedObjectContext:context];
                [event setServerId:[NSNumber numberWithInteger:serverId]];
            }

            [event updateAttributes:dictionary];

            currentRecord++;

            dispatch_async(dispatch_get_main_queue(), ^{
                float percent = ((float)currentRecord) / totalRecords;
                [_hud setProgress:percent];
            });
        }

        NSError *error = nil;
        if ([context save:&error]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_hud setLabelText:NSLocalizedString(@"DONE", nil)];
                _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                _hud.mode = MBProgressHUDModeCustomView;
                [_hud hide:YES afterDelay:2.0];
            });
        } else {
            NSLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
            exit(1);
        }
    });
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
