//
//  ViewController.m
//  RSS
//
//  Created by Timothy Death on 2/06/13.
//  Copyright (c) 2013 Timothy Death. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    rssFeed = [[RSSFeedView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    rssFeed.delegate = self;
    [rssFeed setRssURL:[NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"]];
    [self.view addSubview:rssFeed];
    [rssFeed getFeedResults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didSelectRowWithData:(NSDictionary *)data {
    NSLog(@"Data:%@", data);
    
}

-(void)URLisInvalid
{
    NSLog(@"We need to set a real URL");
}

@end
