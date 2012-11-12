//
//  CSModel.h
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const CSDataForViewWereChangedNotification;
extern NSString* const CSCurrentColorDidChangeNotification;

@protocol ModelDelegateProtocol <NSObject>
- (void) loadColorShemeDataFromFileName: (NSString*) aFileName;
- (void) reloadColorShemeDataFromLastFileName;
- (void) saveCurrentColorShemeDataToFileName: (NSString*) aFileName;
- (void) setCurrentRow: (NSNumber*) aRow forLevel: (NSString*) aLevel;
- (void) currentAppViewerDidChange: (NSString*) aNewAppViewer;
- (void) currentObjectDidChange: (NSString*) aNewObject;
- (void) currentAppViewerDidDelete;
- (void) currentObjectDidDelete;
- (void) addAppViewer: (NSString*) aNewAppViewer;
- (void) addObject:  (NSString*) aNewObject;
- (void) newScheme;
@end

@interface CSModel : NSObject <ModelDelegateProtocol>
{
    
    NSMutableDictionary* colorShemeData;
    
    NSString* currPlistFile;

    // Levels
    NSMutableArray* appViewers;
    NSMutableArray* objects;
    NSMutableDictionary* RGBAcolor;

    NSMutableDictionary* currAppViewerDict;
    
    NSInteger rowappViewers;
    NSInteger rowobjects;
    NSInteger rowRGBAcolor;
}

@property(nonatomic, copy) NSString* currPlistFile;

@property(nonatomic, retain) NSMutableArray* appViewers;
@property(nonatomic, retain) NSMutableDictionary* currAppViewerDict;
@property(nonatomic, retain) NSMutableArray* objects;
@property(nonatomic, retain) NSMutableDictionary* RGBAcolor;

@property(nonatomic, assign) NSInteger rowappViewers;
@property(nonatomic, assign) NSInteger rowobjects;
@property(nonatomic, assign) NSInteger rowRGBAcolor;

@end

