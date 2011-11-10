//
//  Settings.h
//  MacUnwand
//
//  Created by Moiz Merchant on 11/9/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//
// NOTE: This class is not being used, left in place for reference only.
//

//-----------------------------------------------------------------------------
// imports
//-----------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

//-----------------------------------------------------------------------------
// interface definition
//-----------------------------------------------------------------------------

@interface Settings : NSObject 
{
    BOOL mShowConfigPanel;
    BOOL mAutoLoadDefaultWandFile;
}

//-----------------------------------------------------------------------------

@property(assign) BOOL showConfigPanel;
@property(assign) BOOL autoLoadDefaultWandFile;

//-----------------------------------------------------------------------------

+ (Settings*) getSettings;

- (void) save;

//-----------------------------------------------------------------------------

@end
