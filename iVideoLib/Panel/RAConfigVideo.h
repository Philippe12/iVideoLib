//
//  RAConfigPhoto.h
//  NoteBinder
//
//  Created by Philippe Fouquet on 27/11/2013.
//  Copyright (c) 2013 Philippe Fouquet. All rights reserved.
//

#import "RAPanelController.h"
#import "Video.h"
#import <AVKit/AVKit.h>

@interface RAConfigVideo : RAPanelController <NSTableViewDelegate>
{
@private
    Video *mVideo;
}

@property (strong) IBOutlet AVPlayerView *PlayerView;
@property (strong) IBOutlet NSArrayController *ListeChapitre;

- (void)setPresistent:(id)val;
- (void)setUrlToPlayer;

- (IBAction)OpenVideo:(id)sender;
- (IBAction)GetPicture:(id)sender;
- (IBAction)AddChapitre:(id)sender;

@end
