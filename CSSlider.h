//
//  CSSlider.h
//  CSEditor
//
//  Created by Sergey Krotkih on 26.06.11.
//  Copyright 2011 Quickoffice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSSlider : NSSlider
{
    IBOutlet NSString* color;
}

- (float) colorValue;
- (void) setColorValue: (float) aNewValue;

@end