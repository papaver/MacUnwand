//
//  MacUnwandAppDelegate.h
//  MacUnwand
//
//  Created by Moiz Merchant on 10/15/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// imports
//-----------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

//-----------------------------------------------------------------------------
// forward declarations
//-----------------------------------------------------------------------------

@class WandDataController;

//-----------------------------------------------------------------------------
// interface definition
//-----------------------------------------------------------------------------

@interface MacUnwandAppDelegate : NSObject <NSApplicationDelegate> 
{
    NSWindow           *mWindow;
    WandDataController *mWandDataController;
}

//-----------------------------------------------------------------------------

@property (assign) IBOutlet NSWindow           *window;
@property (assign) IBOutlet WandDataController *wandDataController;
    
//-----------------------------------------------------------------------------

@end
