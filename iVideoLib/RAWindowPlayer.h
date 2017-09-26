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
#import "RAPanelController.h"

@interface RAWindowPlayer : RAPanelController
{
@private
    Video *mVideo;
    id self_ptr;
}
@property (strong) IBOutlet AVPlayerView *PlayerView;
@property (strong) IBOutlet NSCollectionView *ListeViewChapitre;

@property (strong) IBOutlet NSArrayController *ListeChapitre;
- (IBAction)sliderChange:(id)sender;
@property (strong) IBOutlet NSSliderCell *sliderVideo;

- (id)initLoc;
- (void)setPresistent:(id)val;
- (void)simpleClick:(id)sender;

@end
