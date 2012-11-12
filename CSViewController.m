//
//  CSViewController.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSViewController.h"
#import "CSEditViewController.h"

@implementation CSViewController

- (id)initWithNibName: (NSString*) nibNameOrNil 
               bundle: (NSBundle*) nibBundleOrNil
{
    self = [super initWithNibName: nibNameOrNil 
                           bundle: nibBundleOrNil];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}


- (void)viewWillLoad 
{
    
}

- (void)viewDidLoad 
{
    [editViewController openOfDefaultShemeDataFile];
}

- (void)loadView 
{
    [self viewWillLoad];
    [super loadView];
    [self viewDidLoad];
}


@end
