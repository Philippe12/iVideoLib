//
//  RAViewConfigVideo.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 11/04/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RAViewBase.h"
#import <Cocoa/Cocoa.h>
#import "Video+CoreDataClass.h"
#import <AVKit/AVKit.h>


@interface RAViewConfigVideo : RAViewBase <NSOutlineViewDelegate, NSOpenSavePanelDelegate>{
@private
    Video *mVideo;
    NSURL *loadingVideo;
}

- (void)reloadData;

@property (strong) IBOutlet AVPlayerView *PlayerView;
@property (strong) IBOutlet NSArrayController *ListeVideo;
@property (strong) IBOutlet NSTreeController *ChapitreTree;
@property (strong) IBOutlet NSOutlineView *Outline;

- (void)setPresistent:(id)val;
- (void)setUrlToPlayer;

- (IBAction)OpenVideo:(id)sender;
- (IBAction)GetPicture:(id)sender;
- (IBAction)AddChapitre:(id)sender;
- (IBAction)RemoveChapitre:(id)sender;

@end
