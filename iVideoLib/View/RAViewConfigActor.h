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


@interface RAViewConfigActor : RAViewBase <NSOpenSavePanelDelegate>{
@private
    Actor *mActor;
}

- (void)reloadData;

@property (strong) IBOutlet NSArrayController *ListeActor;

- (void)setPresistent:(id)val;

@end
