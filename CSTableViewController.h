//
//  CSTableView.h
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CSModel.h"

@class CSTableViewDataSource;

@interface CSTableViewController : NSTableView <NSTableViewDelegate>
{
    IBOutlet NSString* level;
    IBOutlet CSTableViewDataSource* tableViewDataSource;
    IBOutlet id<ModelDelegateProtocol> modeldelegate; 
    IBOutlet CSModel* model;
}

@property (readwrite, nonatomic, copy) IBOutlet NSString* level;

@end
