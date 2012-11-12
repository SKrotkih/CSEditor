//
//  CSTableViewDataSource.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSTableViewDataSource.h"

@implementation CSTableViewDataSource

@synthesize dataSource;

- (void) dealloc
{
    self.dataSource = nil;

    [super dealloc];
}

- (void) sortUsingDescriptors: (NSArray*) sortDescriptors
{
    [(NSMutableArray*)dataSource sortUsingDescriptors: sortDescriptors];
}

#pragma mark implementation of the NSTableViewDataSource protocol

- (id)          tableView: (NSTableView*) aTableView 
objectValueForTableColumn: (NSTableColumn*) aTableColumn 
                      row: (NSInteger) rowIndex
{
    NSArray* ds = (NSArray*)dataSource;
    id theValue = nil;
    if (ds != nil && [ds count] > 0)
    {
        theValue = [ds objectAtIndex: rowIndex];                        
    }
    
    return theValue;
}

- (NSInteger) numberOfRowsInTableView: (NSTableView*) aTableView
{
    return [(NSArray*)dataSource count];
}


@end
