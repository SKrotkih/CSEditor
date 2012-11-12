//
//  CSMainWindow.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSMainWindow.h"
#import "CSEditViewController.h"
#import "CSSlider.h"

@interface CSMainWindow()
- (void) refreshColorWell;
@end

@implementation CSMainWindow

@synthesize editAppViewer;
@synthesize editObject;
@synthesize sliderR;
@synthesize sliderG;
@synthesize sliderB;    
@synthesize sliderA;
@synthesize colorWell;

- (void) awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(dataForViewWereChangedWithNotification:)
                                                 name: CSDataForViewWereChangedNotification
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(textDidEndEditing:)  
                                                 name: NSControlTextDidEndEditingNotification 
                                               object: editAppViewer];    
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(textDidEndEditing:)  
                                                 name: NSControlTextDidEndEditingNotification 
                                               object: editObject];    
}

- (void) dataForViewWereChangedWithNotification: (NSNotification*) notification
{
    NSDictionary* userData = [notification userInfo];
    
    NSString* currAppViewerName = [userData objectForKey: @"currAppViewerName"];
    if (currAppViewerName != nil)
    {
        [editAppViewer setStringValue: currAppViewerName];
    }
    NSString* currObjectName = [userData objectForKey: @"currObjectName"];
    if (currObjectName != nil)
    {
        [textForTheSourceModule setStringValue: [NSString stringWithFormat: @"UIColor* %@Color = [QOColorManager colorFor: %@];", currObjectName, currObjectName]];
        [editObject setStringValue: currObjectName];
    }
    
    NSString* colorR = [userData objectForKey: @"R"];
    if (colorR != nil)
    {
        [sliderR setColorValue: [colorR floatValue]];
        [self refreshColorWell];
    }
    NSString* colorG = [userData objectForKey: @"G"];
    if (colorG != nil)
    {
        [sliderG setColorValue: [colorG floatValue]];
        [self refreshColorWell];
    }
    NSString* colorB = [userData objectForKey: @"B"];
    if (colorB != nil)
    {
        [sliderB setColorValue: [colorB floatValue]];
        [self refreshColorWell];
    }
    NSString* colorA = [userData objectForKey: @"A"];
    if (colorA != nil)
    {
        [sliderA setColorValue: [colorA floatValue]];
        [self refreshColorWell];
    }
}

#pragma mark -
#pragma mark Change object's color

- (void) refreshColorWell
{ 
    NSColor* color = [NSColor colorWithCalibratedRed: [sliderR colorValue]
                                               green: [sliderG colorValue]
                                                blue: [sliderB colorValue]
                                               alpha: [sliderA colorValue]];
    [colorWell setColor: color];
}

- (IBAction) slide: (id) sender
{ 
	if ([sender isKindOfClass: [CSSlider class]] == YES)
    {
        CSSlider* rgbaSlider = (CSSlider*)sender;
        [rgbaSlider setColorValue: [rgbaSlider colorValue]]; 
        [self refreshColorWell];        
    }
    else
    {
        NSAssert(NO, @"Invalid sender");
    }
}

- (void) changeColor: (id) sender
{
	if ([sender isKindOfClass: [NSColorPanel class]] == YES)
    {
        NSColor* color = [(NSColorPanel*)sender color];
        CGFloat r, g, b, a;    
        [color getRed: &r green: &g blue: &b alpha: &a];
        
        [sliderR setColorValue: r];
        [sliderG setColorValue: g];
        [sliderB setColorValue: b];
        [sliderA setColorValue: a];
        
        [colorWell setColor: color];
    }
    else
    {
        NSAssert(NO, @"Invalid sender");
    }
}

#pragma mark -

- (void) textDidEndEditing: (NSNotification*) aNotification
{
    if([aNotification object] == editAppViewer)
	{
        [modeldelegate currentAppViewerDidChange: [editAppViewer stringValue]];
    }
    else if ([aNotification object] == editObject)
    {
        [modeldelegate currentObjectDidChange: [editObject stringValue]];
    }
}

@end
