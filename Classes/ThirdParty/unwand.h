//
//  unwand.h
//  MacUnwand
//
//  Created by Moiz Merchant on 10/15/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// includes
//-----------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

//-----------------------------------------------------------------------------
// interface definition
//-----------------------------------------------------------------------------

@interface Unwand : NSObject
{
}

//-----------------------------------------------------------------------------

+ (NSArray*) decryptWand:(NSString*)filepath;

//-----------------------------------------------------------------------------

@end
