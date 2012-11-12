//
//  CSTableViewController.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSTableViewController.h"
#import "CSTableViewDataSource.h"
#import "CSRGBATableViewDataSource.h"

@implementation CSTableViewController

@synthesize level;

- (void) awakeFromNib
{
    self.delegate = self;
    [model addObserver: self 
            forKeyPath: level
               options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld 
               context: nil];
}

- (void)dealloc
{
    self.level = nil;
    
    [super dealloc];
}

- (void) observeValueForKeyPath: (NSString*) aKeyPath 
                       ofObject: (id) anObject 
                         change: (NSDictionary*) aChange 
                        context: (void*) aContext
{
    if ([aKeyPath isEqualToString: level])
    {
        tableViewDataSource.dataSource = [aChange objectForKey: @"new"];
        [self reloadData];
    }
    else 
    {
        [super observeValueForKeyPath: aKeyPath 
                             ofObject: anObject 
                               change: aChange 
                              context: aContext];
    }
}

#pragma mark implementation of the NSTableViewDelegate protocol

- (void)tableView: (NSTableView*) aTableView sortDescriptorsDidChange: (NSArray* ) oldDescriptors
{
    [tableViewDataSource sortUsingDescriptors: [aTableView sortDescriptors]];
        [self reloadData];
}

- (BOOL) tableView: (NSTableView*) aTableView 
   shouldSelectRow: (NSInteger) rowIndex
{
    [modeldelegate setCurrentRow: [NSNumber numberWithInt: rowIndex] forLevel: level];
    return YES;
}

- (CGFloat)tableView:(NSTableView* )tableView heightOfRow:(NSInteger)row
{
    return 18;
}

#pragma mark -

@end
