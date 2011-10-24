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
    NSMutableArray *mWandData;
    NSPredicate    *mSearchFilter;
    NSString       *mWandFile;
}

//-----------------------------------------------------------------------------

@property (nonatomic, retain) NSMutableArray *wandData;
@property (nonatomic, retain) NSPredicate    *searchFilter;
@property (nonatomic, retain) NSString       *wandFile;

//-----------------------------------------------------------------------------


@end
