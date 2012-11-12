//
//  CSRGBATableViewDataSource.h
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTableViewDataSource.h"
#import "CSModel.h"

@interface CSRGBATableViewDataSource : CSTableViewDataSource
{
    IBOutlet CSModel* model;
}

@end
