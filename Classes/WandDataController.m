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

@synthesize wandData     = mWandData;
@synthesize searchFilter = mSearchFilter;
@synthesize wandFile     = mWandFile;

//-----------------------------------------------------------------------------

- (id) init
{
    self = [super init];
    if (self) {
        self.wandData     = $array(nil);
        self.searchFilter = [NSPredicate predicateWithFormat:nil];
    }
    return self;
}

//-----------------------------------------------------------------------------

- (void) setWandFile:(NSString*)wandFile
{
    // release existing data
    if (mWandFile != nil) {
        [mWandFile release];
    }

    // save data
    mWandFile = wandFile;
    [mWandFile retain];

    // update wand data
    self.wandData = [WandData decryptWand:mWandFile];
}

//-----------------------------------------------------------------------------

- (void) dealloc
{
    [super dealloc];
    [mWandData release];
    [mWandFile release];
}

//-----------------------------------------------------------------------------

@end
