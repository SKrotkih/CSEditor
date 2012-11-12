//
//  CSEditorAppDelegate.h
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CSViewController;

@interface CSEditorAppDelegate : NSObject <NSApplicationDelegate> 
{
	IBOutlet NSWindowController* windowController;

    CSViewController* viewController;
}

@end

