//
//  RAWindowPlayer.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 16/02/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RAWindowPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Chapitre.h"

@interface RAWindowPlayer ()

@property AVPlayer *player;

@end

@implementation RAWindowPlayer

- (id)initWithWindow:(NSWindow *)window
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
    [self setUrlToPlayer];

    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    [_ListeChapitre setSortDescriptors:[NSArray arrayWithObject:sort]];
}

- (id)initLoc {
	self = [super initWithWindowNibName:@"RAWindowPlayer"];
    self_ptr = self;
	return self;
}

- (void)setPresistent:(id)val
{
    mVideo = val;
    [self setUrlToPlayer];
}

- (void)setUrlToPlayer {
    if (mVideo) {
        if( mVideo.url != nil )
        {
            NSURL *url = [NSURL URLWithString:mVideo.url];
            self.PlayerView.player = nil;
            _player = [AVPlayer playerWithURL:url];
            self.PlayerView.player = _player;
        }
    }
}

- (void)simpleClick:(id)sender {
    Chapitre *sel = [[_ListeViewChapitre itemAtIndex:[[_ListeViewChapitre selectionIndexes] firstIndex]] representedObject];
     
    if (sel) {
        [_player.currentItem seekToTime:CMTimeMake([sel.position doubleValue], [sel.scale doubleValue]) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
}

@end
