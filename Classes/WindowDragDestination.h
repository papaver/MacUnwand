//
//  WindowDragDestination.h
//  MacUnwand
//
//  Created by Moiz Merchant on 10/16/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// import
//-----------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

//-----------------------------------------------------------------------------
// interface delegate
//-----------------------------------------------------------------------------

@protocol WindowDragDestinationDelegate <NSObject>
@optional
    - (NSDragOperation) draggingEntered:(id<NSDraggingInfo>)sender;
    - (NSDragOperation) draggingUpdated:(id<NSDraggingInfo>)sender;
    - (void) draggingEnded:(id<NSDraggingInfo>)sender;
    - (void) draggingExited:(id<NSDraggingInfo>)sender;
    - (BOOL) prepareForDragOperation:(id<NSDraggingInfo>)sender;
    - (BOOL) performDragOperation:(id<NSDraggingInfo>)sender;
    - (void) concludeDragOperation:(id<NSDraggingInfo>)sender;
@end

//-----------------------------------------------------------------------------
// interface definition
//-----------------------------------------------------------------------------

@interface WindowDragDestination : NSWindow
{
    id<WindowDragDestinationDelegate> mDragDelegate;
}

//-----------------------------------------------------------------------------

@property(nonatomic, retain) IBOutlet id<WindowDragDestinationDelegate> dragDelegate;

//-----------------------------------------------------------------------------

@end
