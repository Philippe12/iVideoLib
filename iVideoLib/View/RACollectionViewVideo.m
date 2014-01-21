//
//  RACollectionViewVideo.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 21/01/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RACollectionViewVideo.h"

@implementation RACollectionViewVideo

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

- (NSView *)hitTest:(NSPoint)aPoint
{
    // don't allow any mouse clicks for subviews in this view
	if(NSPointInRect(aPoint,[self convertRect:[self bounds] toView:[self superview]])) {
		return self;
	} else {
		return nil;
	}
}

-(void)mouseDown:(NSEvent *)theEvent {
	[super mouseDown:theEvent];
	
	// check for click count above one, which we assume means it's a double click
	if([theEvent clickCount] > 1) {
		if(self.delegate && [self.delegate respondsToSelector:@selector(doubleClick:)]) {
			[self.delegate performSelector:@selector(doubleClick:) withObject:self];
		}
	}
    else {
		if(self.delegate && [self.delegate respondsToSelector:@selector(simpleClick:)]) {
			[self.delegate performSelector:@selector(simpleClick:) withObject:self];
		}
    }
}

@end
