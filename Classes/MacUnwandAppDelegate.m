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

#import "MacUnwandAppDelegate.h"
#import "WandDataController.h"

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

- (void) applicationDidFinishLaunching:(NSNotification*)notification 
{
    // register the valid drag types
    NSArray *dragTypes = $array(NSFilenamesPboardType, nil);
    [self.window registerForDraggedTypes:dragTypes];

    // set the default wand file
    NSString *defaultPath = $string(kDefaultWandFile);
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

@end
