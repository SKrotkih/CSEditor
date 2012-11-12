//
//  CSEditorAppDelegate.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSEditorAppDelegate.h"
#import "CSViewController.h"

@implementation CSEditorAppDelegate

- (void)applicationDidFinishLaunching: (NSNotification*) aNotification 
{
    viewController = [[CSViewController alloc] initWithNibName: @"MainWindow" 
                                                        bundle: [NSBundle mainBundle]];
    
    [windowController.window.contentView addSubview: viewController.view];
}

- (void)dealloc
{
    [viewController release];
    
    [super dealloc];
}

@end
