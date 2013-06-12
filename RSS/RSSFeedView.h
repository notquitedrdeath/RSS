//
//  RSSFeedView.h
//  RSSFeed
//
//  Created by Timothy Death on 2/06/13.
//  Copyright (c) 2013 Timothy Death. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RSSFeedDelegate <NSObject>

@required
-(void) didSelectRowWithData: (NSDictionary *) data;
-(void) URLisInvalid;

@end

@interface RSSFeedView : UIView <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>
{
    UITableView * resultsTable;
    NSXMLParser * parser;
    NSMutableArray * results;
    NSMutableDictionary * item;
    NSMutableString * title;
    NSMutableString * link;
    NSMutableString * description;
    NSString * element;
}

-(void) getFeedResults;

@property(strong, nonatomic) NSURL * rssURL;
@property(nonatomic) NSInteger windowSize;
@property(nonatomic) NSInteger startOffset;
@property(nonatomic, assign) id delegate;

@end
