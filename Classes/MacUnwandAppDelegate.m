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

//-----------------------------------------------------------------------------
// interface implementation
//-----------------------------------------------------------------------------

@implementation MacUnwandAppDelegate

//-----------------------------------------------------------------------------

@synthesize window             = mWindow;
@synthesize wandDataController = mWandDataController;

//-----------------------------------------------------------------------------
#pragma mark -
#pragma mark Application life cycle
//-----------------------------------------------------------------------------

- (void) applicationDidFinishLaunching:(NSNotification*)notification 
{
/*
    NSError *error;
    SFAuthorization *authorization = [SFAuthorization authorization];
    BOOL result                    = [authorization obtainWithRights:NULL
                                                               flags:kAuthorizationFlagExtendRights
                                                         environment:NULL
                                                    authorizedRights:NULL
                                                               error:&error];

    if (!result) {
        NSLog(@"SFAuthorization error: %@", [error localizedDescription]); 
        return;
    }

// Create authorization reference
OSStatus status;
AuthorizationRef authorizationRef;

// AuthorizationCreate and pass NULL as the initial
// AuthorizationRights set so that the AuthorizationRef gets created
// successfully, and then later call AuthorizationCopyRights to
// determine or extend the allowable rights.
// http://developer.apple.com/qa/qa2001/qa1172.html
status = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment,
                             kAuthorizationFlagDefaults, &authorizationRef);
if (status != errAuthorizationSuccess)
    NSLog(@"Error Creating Initial Authorization: %d", status);

// kAuthorizationRightExecute == "system.privilege.admin"
AuthorizationItem right = {kAuthorizationRightExecute, 0, NULL, 0};
AuthorizationRights rights = {1, &right};
AuthorizationFlags flags = kAuthorizationFlagDefaults |
                           kAuthorizationFlagInteractionAllowed |
                           kAuthorizationFlagPreAuthorize |
                           kAuthorizationFlagExtendRights;

// Call AuthorizationCopyRights to determine or extend the allowable rights.
status = AuthorizationCopyRights(authorizationRef, &rights, NULL, flags, NULL);
if (status != errAuthorizationSuccess)
    NSLog(@"Copy Rights Unsuccessful: %d", status);
*/


    // register the valid drag types
    NSArray *dragTypes = $array(NSFilenamesPboardType, nil);
    [self.window registerForDraggedTypes:dragTypes];

    // set the default wand file
    NSString *defaultPath = $string(kDefaultWandFile);
    self.wandDataController.wandFile = [defaultPath stringByExpandingTildeInPath];
}

//-----------------------------------------------------------------------------

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)application
{
    return YES;
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

@end
