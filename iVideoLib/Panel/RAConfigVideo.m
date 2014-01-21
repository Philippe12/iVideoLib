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

@interface RAConfigVideo ()

@property AVPlayer *player;

@end

@implementation RAConfigVideo

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
}
- (id)initLoc {
	self = [super initWithWindowNibName:@"RAConfigVideo"];
    
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

- (IBAction)OpenVideo:(id)sender {
    NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
    [openPanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
		if (result == NSFileHandlingPanelOKButton) {
            NSURL *url = [openPanel URL];
            if (mVideo) {
                mVideo.url = [url absoluteString];
                [self setUrlToPlayer];
            }
		} else {
			[openPanel close];
		}
	}];
}

NSImage* cgImageToNSImage(CGImageRef image)
{
    unsigned long h, w;
    h = CGImageGetHeight(image);
    w = CGImageGetWidth(image);
    NSMutableData* imgData = [NSMutableData dataWithLength: h * w * 4];
    CGImageDestinationRef dest = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)(imgData), kUTTypeTIFF, 1, NULL);
    CGImageDestinationAddImage(dest, image, NULL);
    CGImageDestinationFinalize(dest);
    NSImage* img = [[NSImage alloc]initWithData: imgData];
    CFRelease (dest);
    return img;
}

- (NSImage *)screenshotFromPlayer:(AVPlayer *)player {
    
    CMTime actualTime;
    NSError *error;
    
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:player.currentItem.asset];
    
    // Setting a maximum size is not necessary for this code to
    // successfully get a screenshot, but it was useful for my project.
    generator.maximumSize = CGSizeMake(1000,1000);
    
    CGImageRef cgIm = [generator copyCGImageAtTime:player.currentTime
                                        actualTime:&actualTime
                                             error:&error];
    //NSImage *image = [[NSImage alloc] initWithCGImage:cgIm size:(NSSize){ 50.0, 50.0 }];
    NSImage *image = cgImageToNSImage(cgIm);
    CFRelease(cgIm);
    
    if (nil != error) {
        NSLog(@"Error making screenshot: %@", [error localizedDescription]);
        NSLog(@"Actual screenshot time: %f Requested screenshot time: %f", CMTimeGetSeconds(actualTime),
              CMTimeGetSeconds(self.player.currentTime));
        return nil;
    }
    
    return image;
}

- (IBAction)GetPicture:(id)sender {
    NSImage *img = [self screenshotFromPlayer:_player];
    if (mVideo && img) {
        NSArray *representations = [img representations];
        NSNumber *compressionFactor = [NSNumber numberWithFloat:0.9];
        NSDictionary *imageProps = [NSDictionary dictionaryWithObject:compressionFactor
                                                               forKey:NSImageCompressionFactor];
        mVideo.photo = [NSBitmapImageRep representationOfImageRepsInArray:representations
                                                                      usingType:NSJPEGFileType
                                                                     properties:imageProps];
    }

}

@end
