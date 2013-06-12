//
//  ViewController.h
//  RSS
//
//  Created by Timothy Death on 2/06/13.
//  Copyright (c) 2013 Timothy Death. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSFeedView.h"

@interface ViewController : UIViewController <RSSFeedDelegate>
{
    RSSFeedView * rssFeed;
}

@end
