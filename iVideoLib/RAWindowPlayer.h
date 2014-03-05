//
//  RAWindowPlayer.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 16/02/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Video.h"
#import <AVKit/AVKit.h>

@interface RAWindowPlayer : NSWindowController
{
@private
    Video *mVideo;
    id self_ptr;
}

@property (strong) IBOutlet AVPlayerView *PlayerView;
@property (strong) IBOutlet NSArrayController *ListeChapitre;

- (id)initLoc;
- (void)setPresistent:(id)val;

@end
