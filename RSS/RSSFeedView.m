//
//  RSSFeedView.m
//  RSSFeed
//
//  Created by Timothy Death on 2/06/13.
//  Copyright (c) 2013 Timothy Death. All rights reserved.
//

#import "RSSFeedView.h"



@implementation RSSFeedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowSize = 0;
        self.startOffset = 0;
        results = [[NSMutableArray alloc] init];
        
        resultsTable = [[UITableView alloc] initWithFrame:frame];
        resultsTable.dataSource = self;
        resultsTable.delegate = self;
        [self addSubview:resultsTable];
    }
    return self;
}

//Begins the download/parsing of the RSS Feed.
-(void) getFeedResults {
    
    //Checks if URL isn't set.
    if(self.rssURL == nil || [self.rssURL isEqual:[NSURL URLWithString:@""]])
    {
        if([self.delegate respondsToSelector:@selector(URLisInvalid)])
            [self.delegate URLisInvalid];
        return;
        
    }
    parser = [[NSXMLParser alloc] initWithContentsOfURL:self.rssURL];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


/*
 Basic window system used. 
 windowSize defines how max number of results to return.
 startOffset defines which point to start from.
 
 Return statements:
 Window Siuze = 0, Return everything from the start offset on.
 -
 Offset =  0; return everything in the window
 -
 If the window is too big for sample of data, (Ex. Array size 5, offset 3, window size 4)
 Only display What is left.
 -
 Return everything from the offset to the end.
 -
 
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.windowSize == 0)
        return results.count - self.startOffset;
    if(self.startOffset == 0)
        return self.windowSize;
    if((self.startOffset + self.windowSize) < results.count)
        return self.windowSize;
    return results.count - self.startOffset;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    //Displays the news titles in each row.
    cell.textLabel.text = [[results objectAtIndex:indexPath.row + self.startOffset] objectForKey: @"title"];
    return cell;
}

//When a user selects a row in the table, send back the affiliated item to the main program.
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(didSelectRowWithData:)])
        [self.delegate didSelectRowWithData:[results objectAtIndex:indexPath.row + self.startOffset]];
}

#pragma mark - XML Parser Delegate
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    element = elementName;
    
    //At the start of a new item, initalise the strings to empty
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
    }
}

//As the feed is parsed, the strings holding the information are filled
-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"description"])
        [description appendString:string];
}

//Once the entire item is parsed, it can be added to the array of elements
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        
        [results addObject:[item copy]];
        
    }
    
}

//Once the results have been parsed, reload the table to display the data.
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [resultsTable reloadData];
    
}

@end
