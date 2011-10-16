//
//  MacUnwandAppDelegate.m
//  MacUnwand
//
//  Created by Moiz Merchant on 10/15/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// imports
//-----------------------------------------------------------------------------

#import "MacUnwandAppDelegate.h"
#import "WandDataController.h"

//-----------------------------------------------------------------------------
// interface implementation
//-----------------------------------------------------------------------------

@implementation MacUnwandAppDelegate

//-----------------------------------------------------------------------------

@synthesize window             = mWindow;
@synthesize wandDataController = mWandDataController;

//-----------------------------------------------------------------------------

- (void) applicationDidFinishLaunching:(NSNotification*)notification 
{
    //self.wandDataController = [[[WandDataController alloc] init] autorelease];

    /*
    self.wandData = [WandData decryptWand:@"/Users/papaver/Library/Opera/wand.dat"];
    for (WandData *data in self.wandData) {
        NSLog(@"%@ %@ %@", data.url, data.user, data.pass);
    }
    */
}

//-----------------------------------------------------------------------------

@end
