//
//  CSEditViewController.h
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CSMainWindow.h"
#import "CSModel.h"

@interface CSEditViewController : NSViewController
{
    IBOutlet CSMainWindow* window;
    IBOutlet id<ModelDelegateProtocol> modeldelegate;    
    NSString* fileColorShemeName;
}

- (IBAction) openPlistFile: (id) sender;
- (IBAction) save: (id) sender;
- (IBAction) undo: (id) sender;
- (IBAction) saveAs: (id) sender;

- (IBAction) newAppViewerPressButton: (id) sender;
- (IBAction) deleteAppViewerPressButton: (id) sender;

- (IBAction) newObjectPressButton: (id) sender;
- (IBAction) deleteObjectPressButton: (id) sender;

- (IBAction) newScheme: (id) sender;

- (void) openOfDefaultShemeDataFile;

@property (nonatomic, readwrite, copy) NSString* fileColorShemeName;

@end
