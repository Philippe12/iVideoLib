//
//  RAConfigPhoto.m
//  NoteBinder
//
//  Created by Philippe Fouquet on 27/11/2013.
//  Copyright (c) 2013 Philippe Fouquet. All rights reserved.
//

#import "RAConfigVideo.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Chapitre+CoreDataClass.h"

@interface RAConfigVideo ()

@property AVPlayer *player;

@end

@implementation RAConfigVideo

- (instancetype)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (instancetype)initLoc {
    self = [super initWithWindowNibName:@"RAConfigVideo"];
    
    return self;
}

- (void)setPresistent:(id)val
{
    [_View setPresistent:val];
}

@end
