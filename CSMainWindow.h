//
//  CSMainWindow.h
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CSModel.h"

@class CSSlider;

@interface CSMainWindow : NSWindow
{
    IBOutlet NSButton* newAppViewer;
    IBOutlet NSButton* deleteAppViewer;
    
    IBOutlet NSButton* newObject;
    IBOutlet NSButton* deleteObject;
    
    IBOutlet NSTextField* editAppViewer;
    IBOutlet NSTextField* editObject;
    
    IBOutlet NSTextField* textForTheSourceModule;
    
    IBOutlet CSSlider* sliderR;
    IBOutlet CSSlider* sliderG;
    IBOutlet CSSlider* sliderB;    
    IBOutlet CSSlider* sliderA;
    
    IBOutlet NSColorWell* colorWell;
    
    IBOutlet id<ModelDelegateProtocol> modeldelegate;
}

@property (assign) IBOutlet NSTextField* editAppViewer;
@property (assign) IBOutlet NSTextField* editObject;
@property (assign) IBOutlet CSSlider* sliderR;
@property (assign) IBOutlet CSSlider* sliderG;
@property (assign) IBOutlet CSSlider* sliderB;    
@property (assign) IBOutlet CSSlider* sliderA;
@property (assign) IBOutlet NSColorWell* colorWell;

- (IBAction) slide: (id) sender;

@end
