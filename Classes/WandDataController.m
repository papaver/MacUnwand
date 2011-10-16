//
//  WandDataController.m
//  MacUnwand
//
//  Created by Moiz Merchant on 10/16/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// includes
//-----------------------------------------------------------------------------

#import "WandDataController.h"
#import "WandData.h"

//-----------------------------------------------------------------------------
// interface implementation
//-----------------------------------------------------------------------------

@implementation WandDataController

//-----------------------------------------------------------------------------

@synthesize wandData = mWandData;

//-----------------------------------------------------------------------------

- (id) init
{
    self = [super init];
    if (self) {
        self.wandData = [WandData decryptWand:@"/Users/papaver/Library/Opera/wand.dat"];
    }
    return self;
}

//-----------------------------------------------------------------------------

- (void) dealloc
{
    [super dealloc];
    [mWandData release];
}

//-----------------------------------------------------------------------------

@end
