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
#import "../View/RAViewConfigVideo.h"

@interface RAConfigVideo : RAPanelController

@property (strong) IBOutlet RAViewConfigVideo *View;
- (void)setPresistent:(id)val;

@end
