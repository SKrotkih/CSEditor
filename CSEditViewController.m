//
//  CSEditViewController.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSEditViewController.h"

NSString* const UserDefaultsKeyForDataFileName = @"colorShemeDataFileName";

@interface CSEditViewController()
- (void) loadColorShemeDataFromFileName: (NSString*) fileName;
- (void) afterOpenFileDialogforWindow: (NSWindow* ) aWindow 
                         callSelector: (SEL) aSelector 
                               forObj: (id) anObj;
- (void) openFileDialog;
- (void) afterSaveDialogforWindow: (NSWindow*) aWindow 
                     callSelector: (SEL) aSelector 
                           forObj: (id) aObj;
@end

@implementation CSEditViewController

@synthesize fileColorShemeName;

- (void) dealloc
{
    self.fileColorShemeName = nil;
    
    [super dealloc];
}

#pragma mark Open plist file with color sheme

- (void) openOfDefaultShemeDataFile
{
    self.fileColorShemeName = [[NSUserDefaults standardUserDefaults] stringForKey: UserDefaultsKeyForDataFileName];
    
    if (fileColorShemeName == nil || [[NSFileManager defaultManager] fileExistsAtPath: fileColorShemeName] == NO)
    {
        [self openFileDialog];
    }
    else
    {
        [self loadColorShemeDataFromFileName: fileColorShemeName];
    }
    
}

-(void) openFileDialog
{
    [self afterOpenFileDialogforWindow: window
                          callSelector: @selector(loadColorShemeDataFromFileName:) 
                                forObj: self]; 
}

- (void) loadColorShemeDataFromFileName: (NSString*) aFileName
{
    self.fileColorShemeName = aFileName;
    
    [[NSUserDefaults standardUserDefaults] setValue: fileColorShemeName forKey: UserDefaultsKeyForDataFileName];
    [modeldelegate loadColorShemeDataFromFileName: fileColorShemeName];

}

- (IBAction) openPlistFile: (id) sender
{
    [self openFileDialog];
}

-(void) afterOpenFileDialogforWindow: (NSWindow*) aWindow 
                        callSelector: (SEL) aSelector 
                              forObj: (id)anObj 
{
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    [openPanel setTreatsFilePackagesAsDirectories: NO];
    [openPanel beginSheetModalForWindow: aWindow completionHandler: ^(NSInteger result) 
     {
         if (result == NSOKButton) 
         {
             [openPanel orderOut: self];
             [anObj performSelector: aSelector 
                         withObject: [openPanel filename] 
                         afterDelay: 0.0];             
         }
     }];
}

#pragma mark save

- (IBAction) save: (id) sender
{
    [modeldelegate saveCurrentColorShemeDataToFileName: self.fileColorShemeName];
}

#pragma mark saveAs

-(void) saveAsToFile: (NSString*) aFileName
{
    if (aFileName == nil) 
    {
        return;
    }
    NSString* fileName = [NSString stringWithString: aFileName];
    if ([[aFileName pathExtension] isEqualToString: @"plist"] == NO) 
    {
        fileName = [NSString stringWithFormat: @"%@.plist", aFileName];
    }
    [modeldelegate saveCurrentColorShemeDataToFileName: fileName];
    self.fileColorShemeName = fileName;
}

- (IBAction) saveAs: (id) sender
{
    [self afterSaveDialogforWindow: window 
                      callSelector: @selector(saveAsToFile:) 
                            forObj: self]; 
}

- (void) afterSaveDialogforWindow: (NSWindow*) aWindow 
                     callSelector: (SEL) aSelector 
                           forObj: (id) aObj 
{
    NSSavePanel* savePanel = [NSSavePanel savePanel];
    [savePanel setTreatsFilePackagesAsDirectories: NO];
    [savePanel beginSheetModalForWindow: aWindow completionHandler: ^(NSInteger result) 
     {
         if (result == NSOKButton) 
         {
             [savePanel orderOut: self];
             [aObj performSelector: aSelector withObject: [savePanel filename] afterDelay:0.0];             
         }
     }];
}

#pragma mark delete row

- (IBAction) deleteAppViewerPressButton: (id) sender
{
    [modeldelegate currentAppViewerDidDelete];
}

- (IBAction) deleteObjectPressButton: (id) sender
{
    [modeldelegate currentObjectDidDelete];
}

#pragma mark Add row

- (IBAction) newAppViewerPressButton: (id) sender
{
    NSTextField* editAppViewer = [window editAppViewer];
    [modeldelegate addAppViewer: [editAppViewer stringValue]];
}

- (IBAction) newObjectPressButton: (id) sender
{
    NSTextField* editObject = [window editObject];    
    [modeldelegate addObject: [editObject stringValue]];
}

- (IBAction) undo: (id) sender
{
    [modeldelegate reloadColorShemeDataFromLastFileName];
}

- (IBAction) newScheme: (id) sender
{
    [modeldelegate newScheme];
}

@end
