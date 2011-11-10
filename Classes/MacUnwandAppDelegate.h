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
#import <WindowDragDestination.h>

//-----------------------------------------------------------------------------
// forward declarations
//-----------------------------------------------------------------------------

@class WandDataController;

//-----------------------------------------------------------------------------
// interface definition
//-----------------------------------------------------------------------------
                                                                  
@interface MacUnwandAppDelegate : NSObject <NSApplicationDelegate, WindowDragDestinationDelegate> 
{
    NSWindow           *mWindow;
    NSPanel            *mConfigPanel;
    WandDataController *mWandDataController;
}

//-----------------------------------------------------------------------------

@property (assign) IBOutlet NSWindow           *window;
@property (assign) IBOutlet NSPanel            *configPanel;
@property (assign) IBOutlet WandDataController *wandDataController;
    
//-----------------------------------------------------------------------------

- (IBAction) openFile:(id)sender;
- (IBAction) saveToFile:(id)sender;
- (IBAction) openHelpWebsite:(id)sender;

- (IBAction) configAlways:(id)sender;
- (IBAction) configYes:(id)sender;
- (IBAction) configNo:(id)sender;

//-----------------------------------------------------------------------------

@end
