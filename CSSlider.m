//
//  CSSlider.m
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import "CSSlider.h"
#import "CSModel.h"

@implementation CSSlider

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code here.
    }
    
    return self;
}

- (float) colorValue
{
    return [super floatValue];
}

- (void) setColorValue: (float) aNewValue
{
    [super setFloatValue: aNewValue];
    NSDictionary* userData = [[NSDictionary alloc] initWithObjectsAndKeys: color, @"color", [NSNumber numberWithFloat: aNewValue], @"value", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName: CSCurrentColorDidChangeNotification
                                                        object: self
                                                      userInfo: userData];
    [userData release];
}

@end
