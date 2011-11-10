//
//  Settings.m
//  MacUnwand
//
//  Created by Moiz Merchant on 11/9/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// imports
//-----------------------------------------------------------------------------

#import "Settings.h"

//-----------------------------------------------------------------------------
// defines
//-----------------------------------------------------------------------------

#define kShowPanel @"ShowConfigPanel"
#define kAutoLoad  @"AutoLoadDefaultWandFile"

//-----------------------------------------------------------------------------
// interface definition
//-----------------------------------------------------------------------------

@interface Settings ()
    - (NSString*) getSettingsPath;
    - (void) loadData;
    - (void) saveData;
@end

//-----------------------------------------------------------------------------
// interface implementation
//-----------------------------------------------------------------------------

@implementation Settings

//-----------------------------------------------------------------------------

@synthesize showConfigPanel         = mShowConfigPanel;
@synthesize autoLoadDefaultWandFile = mAutoLoadDefaultWandFile;

//-----------------------------------------------------------------------------

+ (Settings*) getSettings
{
    static Settings *sSettings = nil;
    if (sSettings == nil) {
        sSettings = [[[Settings alloc] init] retain];
    }
    return sSettings;
}

//-----------------------------------------------------------------------------

- (id) init
{
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}

//-----------------------------------------------------------------------------

- (void) save
{
    [self saveData];
}

//-----------------------------------------------------------------------------
#pragma mark -
#pragma mark Helper Functions
//-----------------------------------------------------------------------------

- (NSString*) getSettingsPath
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
        NSUserDomainMask, YES) objectAtIndex:0];
    NSString *settingsPath = [rootPath stringByAppendingPathComponent:@"Settings.plist"];
    return settingsPath;
}

//-----------------------------------------------------------------------------

- (void) loadData
{
    // use default plist if settings file not found in doc directory
    NSString *settingsPath     = [self getSettingsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:settingsPath]) {
        settingsPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    }

    // load the data from the plist
    NSPropertyListFormat format;
    NSString *errorDescription = nil;
    NSData *settingsXml     = [fileManager contentsAtPath:settingsPath];
    NSDictionary *settings  = (NSDictionary*)[NSPropertyListSerialization
        propertyListFromData:settingsXml 
            mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                      format:&format 
            errorDescription:&errorDescription];

    // check for error
    if (!settings) {
        NSLog(@"Settings: error reading plist: %@, format: %@", 
            errorDescription, format);
    }

    NSNumber *showPanel = [settings objectForKey:kShowPanel];
    NSNumber *autoLoad  = [settings objectForKey:kAutoLoad];

    self.showConfigPanel         = [showPanel boolValue];
    self.autoLoadDefaultWandFile = [autoLoad boolValue];
}

//-----------------------------------------------------------------------------

- (void) saveData
{
    // convert bools to numbers
    NSNumber *showPanel = [NSNumber numberWithBool:self.showConfigPanel];
    NSNumber *autoLoad  = [NSNumber numberWithBool:self.autoLoadDefaultWandFile];

    // create a dictionary with the settings
    NSString *error;
    NSDictionary *settings = $dict($array(kShowPanel, kAutoLoad, nil), 
        $array(showPanel, autoLoad, nil));

    // convert dictionary into data object
    NSData *settingsData = [NSPropertyListSerialization 
        dataFromPropertyList:settings
                      format:NSPropertyListXMLFormat_v1_0
            errorDescription:&error];

    // write to disk
    if (settingsData) {
        NSString *settingsPath = [self getSettingsPath];
        [settingsData writeToFile:settingsPath atomically:YES];
    } else {
        NSLog(@"Settings write error: %@", error);
        [error release];
    }
}

//-----------------------------------------------------------------------------

@end
