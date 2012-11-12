//
//  CSRGBATableViewDataSource.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSRGBATableViewDataSource.h"

@implementation CSRGBATableViewDataSource

#pragma mark implementation of the NSTableViewDataSource protocol

- (id)          tableView: (NSTableView* ) aTableView 
objectValueForTableColumn: (NSTableColumn*) aTableColumn 
                      row: (NSInteger) rowIndex
{
    id theValue = nil;
    if (dataSource != nil && [dataSource count] == 4)
    {
        NSArray* keysInOrder = [NSArray arrayWithObjects: @"R", @"G", @"B", @"A", nil];
        if ([keysInOrder count] > 0 && rowIndex >= 0)
        {
            NSString* key = [[keysInOrder objectAtIndex: rowIndex] description];
            NSString* columnName = [aTableColumn identifier];
            if ([columnName isEqualToString: @"Value"]) 
            {
                NSString* colorComponent = [(NSMutableDictionary*)dataSource objectForKey: key];
                theValue = [NSString stringWithFormat: @"%f", [colorComponent floatValue]];
                NSDictionary* userData = [[NSDictionary alloc] initWithObjectsAndKeys: colorComponent, key, nil];
                [[NSNotificationCenter defaultCenter] postNotificationName: CSDataForViewWereChangedNotification
                                                                    object: self
                                                                  userInfo: userData];
                [userData release];
            }
            else if ([columnName isEqualToString: @"Name"])  
            {
                theValue = [[key copy] autorelease];
            }
            else
            {
                NSAssert(NO, @"Unexpected table column");            
            }
        }
    }
    
    return theValue;
}

#pragma mark save new color data item

- (void) tableView: (NSTableView*) aTableView 
    setObjectValue: (id) anObject 
    forTableColumn: (NSTableColumn*) aTableColumn 
               row: (NSInteger) rowIndex
{
    if (dataSource != nil && [dataSource count] == 4)
    {
        NSArray* keysInOrder = [NSArray arrayWithObjects: @"R", @"G", @"B", @"A", nil];

        // I get aTableColumn = 0 (don't know why), so I need do it!
        rowIndex = model.rowRGBAcolor;
        
        if ([keysInOrder count] > 0 && rowIndex >= 0)
        {
            NSString* key = [[keysInOrder objectAtIndex: rowIndex] description];
            //NSString* columnName = [aTableColumn identifier];
            //if ([columnName isEqualToString: @"Value"]) 
            {
                NSDictionary* userData = [[NSDictionary alloc] initWithObjectsAndKeys: anObject, key, nil];
                [[NSNotificationCenter defaultCenter] postNotificationName: CSDataForViewWereChangedNotification
                                                                    object: self
                                                                  userInfo: userData];
                [userData release];
            }
        }
    }
}

@end
