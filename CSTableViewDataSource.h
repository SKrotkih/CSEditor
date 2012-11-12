//
//  CSTableViewDataSource.h
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTableViewDataSource : NSObject <NSTableViewDataSource>
{
    id dataSource;
}

- (void) sortUsingDescriptors: (NSArray*) sortDescriptors;

@property(nonatomic, readwrite, retain) id dataSource;

@end
