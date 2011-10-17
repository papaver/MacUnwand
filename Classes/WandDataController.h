//
//  WandDataController.h
//  MacUnwand
//
//  Created by Moiz Merchant on 10/16/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// includes
//-----------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

//-----------------------------------------------------------------------------
// interface definition
//-----------------------------------------------------------------------------

@interface WandDataController : NSObject 
{
    NSArray  *mWandData;
    NSString *mWandFile;
}

//-----------------------------------------------------------------------------

@property (nonatomic, retain) NSArray  *wandData;
@property (nonatomic, retain) NSString *wandFile;

//-----------------------------------------------------------------------------

@end
