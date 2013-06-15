//
//  GFAboutViewController.m
//  Gentse Feesten 2013
//
//  Created by Tim Leytens on 5/05/13.
//  Copyright (c) 2013 Tim Leytens. All rights reserved.
//

#import "GFAboutViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GFFontSmall.h"
#import "STTweetLabel.h"

@interface GFAboutViewController ()

@end

@implementation GFAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad {

    [super viewDidLoad];

    self.trackedViewName = @"About";

    UIView *headerLabel = [super headerLabel:[NSLocalizedString(@"ABOUT", nil) uppercaseString]];
    [self.view addSubview:headerLabel];

    UIImage *bodyTop = [UIImage imageNamed:@"tableTop.png"];
    UIImageView *bodyTopView = [[UIImageView alloc] initWithImage:bodyTop];
    bodyTopView.frame = CGRectMake(padding, headerLabel.frame.size.height + headerLabel.frame.origin.y + padding, bodyTop.size.width, bodyTop.size.height);
    [self.view addSubview:bodyTopView];

    UIView *myBackView = [[UIView alloc] initWithFrame:CGRectMake(padding, IS_IOS_7 ? 62 + navBarHeight : 62, self.view.frame.size.width - (padding * 2), self.view.frame.size.height - navBarHeight - (padding * 2) - 62)];
    myBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackground.png"]];
    [self.view addSubview:myBackView];

    STTweetLabel *textView = [[STTweetLabel alloc] initWithFrame:CGRectMake(myBackView.frame.origin.x + padding, myBackView.frame.origin.y + padding, myBackView.frame.size.width - (padding * 2), [super getHeightForString:NSLocalizedString(@"ABOUT_BODY_TEXT", nil)])];
    textView.text = NSLocalizedString(@"ABOUT_BODY_TEXT", nil);
    textView.font = [GFFontSmall sharedInstance];
    textView.textColor = [UIColor darkGrayColor];
    textView.numberOfLines = 0;
    textView.colorLink = UIColorFromRGB(0xed4e40);
    textView.colorHashtag = UIColorFromRGB(0xed4e40);
    [super getHeightForString:NSLocalizedString(@"ABOUT_BODY_TEXT", nil)];


    [textView setCallbackBlock:^(STLinkActionType actionType, NSString *link) {

        switch (actionType) {

            case STLinkActionTypeAccount:
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?%@", link]]];
                }
                else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", [link stringByReplacingOccurrencesOfString:@"@" withString:@""]]]];
                }
                break;

            case STLinkActionTypeHashtag:
                break;

            case STLinkActionTypeWebsite:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
                break;
        }
                
    }];
    
    [self.view addSubview:textView];

    UIView *footer = [super addTableViewFooter];
    footer.frame = CGRectMake(padding, myBackView.frame.origin.y + myBackView.frame.size.height, footer.frame.size.width, footer.frame.size.height);
    [self.view addSubview:footer];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
