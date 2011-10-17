//
//  WindowDragDestination.m
//  MacUnwand
//
//  Created by Moiz Merchant on 10/16/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//-----------------------------------------------------------------------------
// import
//-----------------------------------------------------------------------------

#import "WindowDragDestination.h"

//-----------------------------------------------------------------------------
// interface implementation
//-----------------------------------------------------------------------------

@implementation WindowDragDestination

//-----------------------------------------------------------------------------

@synthesize dragDelegate = mDragDelegate;

//-----------------------------------------------------------------------------

- (void) awakeFromNib
{
    [super awakeFromNib];
}

//-----------------------------------------------------------------------------

- (NSDragOperation) draggingEntered:(id<NSDraggingInfo>)sender
{
    bool responds = [self.dragDelegate respondsToSelector:@selector(draggingEntered:)];
    return responds ? [self.dragDelegate draggingEntered:sender] : [sender draggingSourceOperationMask];
}

//-----------------------------------------------------------------------------

- (NSDragOperation) draggingUpdated:(id<NSDraggingInfo>)sender
{
    bool responds = [self.dragDelegate respondsToSelector:@selector(draggingUpdated:)];
    return responds ? [self.dragDelegate draggingUpdated:sender] : [sender draggingSourceOperationMask];
}

//-----------------------------------------------------------------------------

- (void) draggingEnded:(id<NSDraggingInfo>)sender
{
    bool responds = [self.dragDelegate respondsToSelector:@selector(draggingEnded:)];
    if (responds) [self.dragDelegate draggingEnded:sender];
}

//-----------------------------------------------------------------------------

- (void) draggingExited:(id<NSDraggingInfo>)sender
{
    bool responds = [self.dragDelegate respondsToSelector:@selector(draggingExited:)];
    if (responds) [self.dragDelegate draggingExited:sender];
    
}

//-----------------------------------------------------------------------------

- (BOOL) prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    bool responds = [self.dragDelegate respondsToSelector:@selector(prepareForDragOperation:)];
    return responds ? [self.dragDelegate prepareForDragOperation:sender] : YES;
}

//-----------------------------------------------------------------------------

- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender
{
    bool responds = [self.dragDelegate respondsToSelector:@selector(performDragOperation:)];
    return responds ? [self.dragDelegate performDragOperation:sender] : YES;
}

//-----------------------------------------------------------------------------

- (void) concludeDragOperation:(id<NSDraggingInfo>)sender;
{
    bool responds = [self.dragDelegate respondsToSelector:@selector(concludeDragOperation:)];
    if (responds) [self.dragDelegate concludeDragOperation:sender];
}

//-----------------------------------------------------------------------------

@end
