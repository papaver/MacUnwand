//
//  WandData.h
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
// interface definition
//-----------------------------------------------------------------------------

@interface WandData : NSObject
{
    NSString *mUrl;
    NSString *mUser;
    NSString *mPassword;
}

//-----------------------------------------------------------------------------

@property(nonatomic, retain) NSString *url;
@property(nonatomic, retain) NSString *user;
@property(nonatomic, retain) NSString *pass;

//-----------------------------------------------------------------------------

+ (NSMutableArray*) decryptWand:(NSString*)filepath;

//-----------------------------------------------------------------------------

@end

