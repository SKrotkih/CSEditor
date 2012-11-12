//
//  CSModel.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSModel.h"

NSString* const CSDataForViewWereChangedNotification = @"dataForViewWereChangedWithNotificationNotification";
NSString* const CSCurrentColorDidChangeNotification = @"CurrentColorDidChangeNotification";

@interface CSModel()
- (void) updateData;
@end

@implementation CSModel

@synthesize currPlistFile;
@synthesize appViewers;
@synthesize currAppViewerDict;
@synthesize objects;
@synthesize RGBAcolor;

@synthesize rowappViewers;
@synthesize rowobjects;
@synthesize rowRGBAcolor;

- (id) init
{
	self = [super init];
	if (self != nil) 
    {
        colorShemeData = [[NSMutableDictionary alloc] init];
        appViewers = [[NSMutableArray alloc] init];
        objects = [[NSMutableArray alloc] init];
        RGBAcolor = [[NSMutableDictionary alloc] init];
        self.rowappViewers = 0;
        self.rowobjects = 0;
        self.rowRGBAcolor = 0;
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(currentColorDidChange:)
                                                     name: CSCurrentColorDidChangeNotification
                                                   object: nil];
        
    }
	return self;
}

- (void) dealloc
{
    [colorShemeData release];
    self.currPlistFile = nil;
    [appViewers release];
    [objects release];
    [RGBAcolor release];

	[super dealloc];
}

#pragma mark Load and Reload data

- (void) loadColorShemeDataFromFileName: (NSString*) aFileName
{
	self.currPlistFile = aFileName;
    
    [colorShemeData release];
    colorShemeData = [[NSMutableDictionary alloc] initWithContentsOfFile: aFileName];

    [self updateData];    
}

- (void) reloadColorShemeDataFromLastFileName
{
    [colorShemeData release];
    colorShemeData = [[NSMutableDictionary alloc] initWithContentsOfFile: currPlistFile];
    
    [self updateData];    
}

#pragma mark Save data

- (void) saveCurrentColorShemeDataToFileName: (NSString*) aFileName
{
    if (colorShemeData == nil) 
    {
        return;
    }
    if (aFileName == nil && self.currPlistFile != nil) 
    {
        [colorShemeData writeToFile: self.currPlistFile atomically: YES];
    }
    else if (aFileName != nil)
    {
        [colorShemeData writeToFile: aFileName atomically: YES];        
        self.currPlistFile = aFileName;
    }
    else if (self.currPlistFile == nil)
    {
        NSAssert(NO, @"For save data would be the file name.");
    }
    
}

#pragma mark Select row

- (void) setCurrentRow: (NSNumber*) aRow forLevel: (NSString*) aLevel
{
    [self setValue: aRow forKey: [NSString stringWithFormat: @"row%@",  aLevel]];
    [self updateData];
}    

#pragma mark Edit AppViewer

- (void) currentAppViewerDidChange: (NSString*) aNewAppViewer
{
    BOOL isKeyExist = NO;
    for (NSString* key in self.appViewers) 
    {
        if ([key isEqualToString: aNewAppViewer] == YES) 
        {
            isKeyExist = YES;
        }
    }
    if (isKeyExist == NO)
    {
        NSString* oldKey = [appViewers objectAtIndex: rowappViewers];
        [colorShemeData setObject: currAppViewerDict 
                           forKey: aNewAppViewer];
        [colorShemeData removeObjectForKey: oldKey];
        [self updateData];
    }
    else
    {
        NSBeginAlertSheet(@"Warning!", nil, nil, nil, /*parentController.window,*/ nil, nil, nil, nil, nil, 
                          @"Value '%@' is exist!", aNewAppViewer);
    }
}    

#pragma mark Edit Object

- (void) currentObjectDidChange: (NSString*) aNewObject
{
    BOOL isKeyExist = NO;
    for (NSString* key in self.objects) 
    {
        if ([key isEqualToString: aNewObject] == YES) 
        {
            isKeyExist = YES;
        }
    }
    if (isKeyExist == NO)
    {
        NSString* oldKey = [objects objectAtIndex: rowobjects];
        NSMutableDictionary* currRGBADict = [currAppViewerDict objectForKey: oldKey];
        [currAppViewerDict setObject: currRGBADict 
                              forKey: aNewObject];
        [currAppViewerDict removeObjectForKey: oldKey];
        [self updateData];
    }
    else
    {
        NSBeginAlertSheet(@"Warning!", nil, nil, nil, /*parentController.window,*/ nil, nil, nil, nil, nil, 
                          @"Value '%@' is exist!", aNewObject);
    }
}    

#pragma mark Edit Color


- (void) currentColorDidChange: (NSNotification*) notification
{
    NSDictionary* userData = [notification userInfo];
    [self.RGBAcolor setObject: [userData objectForKey: @"value"] 
                       forKey: [userData objectForKey: @"color"]];
    [self updateData];
}    

#pragma mark Delete AppViewer

- (void) currentAppViewerDidDelete
{
    NSInteger appViewerCount =  [[colorShemeData allKeys] count];
    if (colorShemeData == nil || appViewerCount == 0) 
    {
        return;
    }
    if (appViewerCount == 1)
    {
        NSBeginAlertSheet(@"Warning!", nil, nil, nil, /*parentController.window,*/ nil, 
                          nil, nil, nil, nil, 
                          @"You don't delete AppViewer, beacouse it is alone!");
    }
    else
    {
        NSString* currAppViewerKey = [appViewers objectAtIndex: rowappViewers]; 
        NSBeginAlertSheet(@"Warning!", nil, @"Cancel", nil, /*parentController.window,*/ nil, 
                          self, 
                          @selector(sheetDidEndAppViewerDelete:returnCode:contextInfo:), nil, nil, 
                          @"AppViewer '%@' will delete!\nAre you sure?", currAppViewerKey);
    }
}

- (void) sheetDidEndAppViewerDelete: (NSWindow*) sheet returnCode: (int) aReturnCode contextInfo: (void*) aContextInfo
{
    if (aReturnCode == 1)
    {
        NSString* currAppViewerKey = [appViewers objectAtIndex: rowappViewers];         
        [colorShemeData removeObjectForKey: currAppViewerKey];
        [self updateData];
    }
}

#pragma mark Delete Object

- (void) currentObjectDidDelete
{
    NSInteger objectsCount =  [objects count];
    if (colorShemeData == nil || objectsCount == 0) 
    {
        return;
    }
    NSString* currObjectKey = [objects objectAtIndex: rowobjects];
    NSBeginAlertSheet(@"Warning!", nil, @"Cancel", nil, /*parentController.window,*/ nil, 
                      self, 
                      @selector(sheetDidEndObjectDelete:returnCode:contextInfo:), nil, nil, 
                      @"Object '%@' will delete!\nAre you sure?", currObjectKey);
}

- (void) sheetDidEndObjectDelete: (NSWindow*) sheet returnCode: (int) aReturnCode contextInfo: (void*) aContextInfo
{
    if (aReturnCode == 1)
    {
        NSString* currObjectKey = [objects objectAtIndex: rowobjects];
        [currAppViewerDict removeObjectForKey: currObjectKey];
        [self updateData];
    }
}


- (void) newScheme
{
    [colorShemeData removeAllObjects]; 
    NSNumber* f0 = [NSNumber numberWithFloat: 0.0f];
    NSNumber* f1 = [NSNumber numberWithFloat: 1.0f];
    NSMutableDictionary* newColor = [[NSMutableDictionary alloc] initWithObjectsAndKeys: f0, @"R", f0, @"G", f0, @"B", f1, @"A", nil];
    NSMutableDictionary* newObject = [[NSMutableDictionary alloc] initWithObjectsAndKeys: newColor, @"object", nil];
    [newColor release];
    [colorShemeData setObject: newObject
                       forKey: @"AppViewer"];
    [newObject release];
    [self updateData];
}

#pragma mark Add AppViewer

- (void) addAppViewer: (NSString*) aNewAppViewer
{
    BOOL isKeyExist = NO;
    for (NSString* key in self.appViewers) 
    {
        if ([key isEqualToString: aNewAppViewer] == YES) 
        {
            isKeyExist = YES;
        }
    }
    if (isKeyExist == NO)
    {
        NSNumber* f0 = [NSNumber numberWithFloat: 0.0f];
        NSNumber* f1 = [NSNumber numberWithFloat: 1.0f];
        NSMutableDictionary* newColor = [[NSMutableDictionary alloc] initWithObjectsAndKeys: f0, @"R", f0, @"G", f0, @"B", f1, @"A", nil];
        NSMutableDictionary* newObject = [[NSMutableDictionary alloc] initWithObjectsAndKeys: newColor, @"object", nil];
        [newColor release];
        [colorShemeData setObject: newObject
                           forKey: aNewAppViewer];
        [newObject release];
        [self updateData];
    }
    else
    {
        NSBeginAlertSheet(@"Warning!", nil, nil, nil, /*parentController.window,*/ nil, nil, nil, nil, nil, 
                          @"Value '%@' is exist!", aNewAppViewer);
    }
}

#pragma mark Add Object

- (void) addObject: (NSString*) aNewObject
{
    BOOL isKeyExist = NO;
    for (NSString* key in self.objects) 
    {
        if ([key isEqualToString: aNewObject] == YES) 
        {
            isKeyExist = YES;
        }
    }
    if (isKeyExist == NO)
    {
        NSNumber* f0 = [NSNumber numberWithFloat: 0.0f];
        NSNumber* f1 = [NSNumber numberWithFloat: 1.0f];
        NSMutableDictionary* newColor = [[NSMutableDictionary alloc] initWithObjectsAndKeys: f0, @"R", f0, @"G", f0, @"B", f1, @"A", nil];
        [currAppViewerDict setObject: newColor
                              forKey: aNewObject];
        [newColor release];
        [self updateData];
    }
    else
    {
        NSBeginAlertSheet(@"Warning!", nil, nil, nil, /*parentController.window,*/ nil, nil, nil, nil, nil, 
                          @"Value '%@' is exist!", aNewObject);
    }
}

#pragma mark Update data

- (void) updateData
{
    NSMutableArray* av = [[colorShemeData allKeys] mutableCopy]; 
    self.appViewers = av;
    [av release];
    
    NSString* currAppViewerKey = [appViewers objectAtIndex: rowappViewers];
    self.currAppViewerDict = [colorShemeData objectForKey: currAppViewerKey];
    NSMutableArray* ob = [[currAppViewerDict allKeys] mutableCopy];
    self.objects = ob;
    [ob release];
    
    NSString* currObjectKey = [objects objectAtIndex: rowobjects];
    self.RGBAcolor = [currAppViewerDict objectForKey: currObjectKey];
    
    NSDictionary* userData = [[NSDictionary alloc] initWithObjectsAndKeys: 
                              currAppViewerKey, @"currAppViewerName", 
                              currObjectKey,    @"currObjectName", 
                              nil];
    [[NSNotificationCenter defaultCenter] postNotificationName: CSDataForViewWereChangedNotification
                                                        object: self
                                                      userInfo: userData];
    [userData release];
}

#pragma mark -

@end
