//
//  WandData.m
//  MacUnwand
//
//  Created by Moiz Merchant on 10/15/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// imports
//-----------------------------------------------------------------------------

#import "WandData.h"
#import "unwand.h"

//-----------------------------------------------------------------------------
// define
//-----------------------------------------------------------------------------

#define kStartIndex 5

//-----------------------------------------------------------------------------
// interface implementation
//-----------------------------------------------------------------------------

@implementation WandData 

//-----------------------------------------------------------------------------

@synthesize url  = mUrl;
@synthesize user = mUser;
@synthesize pass = mPass;

//-----------------------------------------------------------------------------

+ (NSArray*) decryptWand:(NSString*)filepath
{
    // decrypt all wand file
    NSArray* strings = [Unwand decryptWand:filepath];

    // setup date formater
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];

    // compile the useful data
    NSMutableArray *wandData = [[[NSMutableArray alloc] init] autorelease];
    for (NSUInteger index = kStartIndex; index < strings.count; ) {

        // advance till date found
        NSString *dateString = [strings objectAtIndex:index];
        NSDate *date         = [dateFormatter dateFromString:dateString];
        if (date == nil) {
            ++index;
            continue;
        }

        // calculate proper indexes
        NSString *entry      = [strings objectAtIndex:index + 2];
        NSUInteger urlIndex  = index + 1;
        NSUInteger userIndex = index + ([entry hasPrefix:@"http"] ? 4 : 5);
        NSUInteger passIndex = index + ([entry hasPrefix:@"http"] ? 6 : 7);

        // save data
        WandData *data = [[[WandData alloc] init] autorelease];
        data.url       = [strings objectAtIndex:urlIndex];
        data.user      = [strings objectAtIndex:userIndex];
        data.pass      = [strings objectAtIndex:passIndex];
        [wandData addObject:data];

        // increment index
        index += [entry hasPrefix:@"http"] ? 7 : 8;
    }
    return wandData;
}

//-----------------------------------------------------------------------------

@end
