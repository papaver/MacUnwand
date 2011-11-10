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

#import <SecurityFoundation/SFAuthorization.h>

#import "MacUnwandAppDelegate.h"
#import "WandDataController.h"
#import "WandData.h"

//-----------------------------------------------------------------------------
// defines
//-----------------------------------------------------------------------------

#define kDefaultWandFile @"~/Library/Opera/wand.dat"
#define kShowPanel       @"ShowConfigPanel"
#define kAutoLoad        @"AutoLoadDefaultWandFile"

//-----------------------------------------------------------------------------
// interface definition
//-----------------------------------------------------------------------------

@interface MacUnwandAppDelegate ()
    - (void) updateConfiguration;
    - (void) loadDefaultWandFile;
@end

//-----------------------------------------------------------------------------
// interface implementation
//-----------------------------------------------------------------------------

@implementation MacUnwandAppDelegate

//-----------------------------------------------------------------------------

@synthesize window             = mWindow;
@synthesize configPanel        = mConfigPanel;
@synthesize wandDataController = mWandDataController;

//-----------------------------------------------------------------------------
#pragma mark -
#pragma mark Application life cycle
//-----------------------------------------------------------------------------

- (void) applicationDidFinishLaunching:(NSNotification*)notification 
{
    // register the valid drag types
    NSArray *dragTypes = $array(NSFilenamesPboardType, nil);
    [self.window registerForDraggedTypes:dragTypes];

    // load user preferences
    NSUserDefaults *preferences      = [NSUserDefaults standardUserDefaults];
    NSString *defaultPreferencesPath = [[NSBundle mainBundle] 
        pathForResource:@"Settings" ofType:@"plist"];
    NSDictionary *dictionary         = [NSDictionary 
        dictionaryWithContentsOfFile:defaultPreferencesPath];
    [preferences registerDefaults:dictionary];

    // read preferences
    BOOL showPanel = [preferences boolForKey:kShowPanel];
    BOOL autoLoad  = [preferences boolForKey:kAutoLoad];

    // show the model configuration window if required
    if (showPanel) {
        [[NSApplication sharedApplication] runModalForWindow:self.configPanel];
    } else if (autoLoad) {
        NSString *defaultPath = $string(kDefaultWandFile);
        self.wandDataController.wandFile = [defaultPath stringByExpandingTildeInPath];
    }
}

//-----------------------------------------------------------------------------

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)application
{
    return YES;
}

//-----------------------------------------------------------------------------
#pragma mark -
#pragma mark Helper Functions
//-----------------------------------------------------------------------------

- (void) updateConfiguration
{
    // sync the preferences with checkbox status
    NSButton *doNotShowCheckbox = [self.configPanel.contentView viewWithTag:1];
    BOOL showPanel              = doNotShowCheckbox.state == NSOffState;
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setBool:showPanel forKey:kShowPanel];
}

//-----------------------------------------------------------------------------

- (void) loadDefaultWandFile
{
    NSString *defaultPath            = $string(kDefaultWandFile);
    self.wandDataController.wandFile = [defaultPath stringByExpandingTildeInPath];
}

//-----------------------------------------------------------------------------
#pragma mark -
#pragma mark Drag and Drop Protocol
//-----------------------------------------------------------------------------

- (NSDragOperation) draggingEntered:(id<NSDraggingInfo>)sender
{
    // check if the operation is valid
    NSDragOperation operation = 
        NSDragOperationGeneric & [sender draggingSourceOperationMask];
    if (operation == NSDragOperationGeneric) {
        NSPasteboard *pasteboard = [sender draggingPasteboard];
        if ([[pasteboard types] containsObject:NSFilenamesPboardType]) {
            NSArray *paths = [pasteboard propertyListForType:NSFilenamesPboardType];
            NSString *path = [paths objectAtIndex:0];

            // check the first entry is a file and not a directory
            BOOL isDir;
            NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
            BOOL fileExists = [fileManager fileExistsAtPath:path isDirectory:&isDir]; 
            if (fileExists && !isDir) {
                return NSDragOperationGeneric;
            }
        }
    }

    return NSDragOperationNone;
}

//-----------------------------------------------------------------------------

- (NSDragOperation) draggingUpdated:(id<NSDraggingInfo>)sender
{
    return [self draggingEntered:sender];
}

//-----------------------------------------------------------------------------

- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender 
{
    // set the first entry in the pasteboard to the wandfile
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    if ([[pasteboard types] containsObject:NSFilenamesPboardType]) {
        NSArray *paths = [pasteboard propertyListForType:NSFilenamesPboardType];
        self.wandDataController.wandFile = [paths objectAtIndex:0];
    }
    
    return YES;
}

//-----------------------------------------------------------------------------
#pragma mark -
#pragma mark Menu Actions
//-----------------------------------------------------------------------------

- (IBAction) openFile:(id)sender
{
    // create the file open panel
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];

    // allow file selection only
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];

    // process the first file in the selection
    if ([openPanel runModalForDirectory:nil file:nil] == NSOKButton) {
        NSArray *files = [openPanel filenames];
        self.wandDataController.wandFile = [files objectAtIndex:0];
    }
}

//-----------------------------------------------------------------------------

- (IBAction) saveToFile:(id)sender
{ 
    
    // create the file save panel
    NSSavePanel *savePanel = [NSSavePanel savePanel];

    // configure panel 
    savePanel.allowedFileTypes     = $array(@"csv", nil);
    savePanel.allowsOtherFileTypes = NO;

    if ([savePanel runModal] == NSOKButton) {
        NSString *filename = [savePanel filename];

        // compile data to export
        NSMutableArray *csvData = [NSMutableArray array];
        NSArray *data           = self.wandDataController.wandData;
        for (WandData *wandData in data) {
            NSString *line = $string(@"%@, %@, %@", wandData.url, wandData.user, wandData.pass);
            [csvData addObject:line];
        }

        // export data 
        NSError *error;
        [[csvData componentsJoinedByString:@"\n"] writeToFile:filename 
                                                   atomically:NO 
                                                     encoding:NSUTF8StringEncoding 
                                                        error:&error];
    }
}

//-----------------------------------------------------------------------------

- (IBAction) openHelpWebsite:(id)sender
{
    NSString *urlPath = @"http://www.bunniesonacid.com/?page_id=18";
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlPath]];
}

//-----------------------------------------------------------------------------
#pragma mark -
#pragma mark Config Pane Action
//-----------------------------------------------------------------------------

- (IBAction) configAlways:(id)sender
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setBool:NO forKey:kShowPanel];
    [preferences setBool:YES forKey:kAutoLoad];

    // load wand file
    [self loadDefaultWandFile];

    // close panel
    [self.configPanel close];
    [[NSApplication sharedApplication] stopModal];
    
    // save preferences
    [preferences synchronize];
}

//-----------------------------------------------------------------------------

- (IBAction) configYes:(id)sender
{
    [self loadDefaultWandFile];
    [self updateConfiguration];
    [self.configPanel close];
    [[NSApplication sharedApplication] stopModal];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//-----------------------------------------------------------------------------

- (IBAction) configNo:(id)sender
{
    [self updateConfiguration];
    [self.configPanel close];
    [[NSApplication sharedApplication] stopModal];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//-----------------------------------------------------------------------------

@end
