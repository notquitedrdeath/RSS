//
//  RSSFeedView.h
//  RSSFeed
//
//  Created by Timothy Death on 2/06/13.
//  Copyright (c) 2013 The Kobold Connective. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSFeedView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * rssFeedResults;
    NSXMLParser * rssParser;
}

@property(strong, nonatomic) NSURL * rssURL;

@end
