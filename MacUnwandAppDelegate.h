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
// imports
//-----------------------------------------------------------------------------

@interface MacUnwandAppDelegate : NSObject <NSApplicationDelegate> 
{
    NSWindow *mWindow;
}

//-----------------------------------------------------------------------------

@property (assign) IBOutlet NSWindow *window;

//-----------------------------------------------------------------------------

@end
