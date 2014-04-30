//
//  RAViewConfigVideo.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 11/04/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RAViewConfigVideo.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Chapitre.h"

@interface RAViewConfigVideo ()

@property AVPlayer *player;

@end

@implementation RAViewConfigVideo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id)initLoc 
{
    self = [super initWithNibName:@"RAViewConfigVideo" bundle:nil];
    return self;
}

- (void)setPresistent:(id)val
{
    mVideo = val;
    [self setUrlToPlayer];
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];
}

- (void)setUrlToPlayer {
    self.PlayerView.player = nil;
    if (mVideo) {
        if( mVideo.url != nil )
        {
            NSURL *url = [NSURL URLWithString:mVideo.url];
            _player = [AVPlayer playerWithURL:url];
            self.PlayerView.player = _player;
        }
    }
    
}

- (void) GetDuration {
    sleep(5); //wait that video are loaded
    Float64 f = CMTimeGetSeconds(_player.currentItem.duration);
    if (mVideo) {
        mVideo.lenght = [[NSNumber alloc] initWithFloat:f];
    }
}

- (BOOL)panel:(id)sender shouldEnableURL:(NSURL *)url {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"Video"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSString *value = [url absoluteString];
    NSString *wildcardedString = [NSString stringWithFormat:@"%@*", value];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url like %@", wildcardedString];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    NSUInteger count = 0;
    if (array != nil) {
        count = [array count]; // May be 0 if the object has been deleted.
    }
    if( count != 0 ) {
        return NO;
    }
    return YES;
}

- (IBAction)OpenVideo:(id)sender {
    NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
    [openPanel setDelegate:self];
    [openPanel beginSheetModalForWindow:[[self view] window] completionHandler:^(NSInteger result) {
		if (result == NSFileHandlingPanelOKButton) {
            NSURL *url = [openPanel URL];
            if (mVideo) {
                mVideo.url = [url absoluteString];
                [self setUrlToPlayer];
                mVideo.lenght = [[NSNumber alloc] initWithFloat: CMTimeGetSeconds(_player.currentItem.duration)];
                if( mVideo.name == nil) {
                    mVideo.name = [[url absoluteString] lastPathComponent];
                }
                [self performSelectorInBackground:@selector(GetDuration) withObject:nil];
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

- (NSData *)screenshotFromPlayer:(AVPlayer *)player {
    
    CMTime actualTime;
    NSError *error;
    
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:player.currentItem.asset];
    
    // Setting a maximum size is not necessary for this code to
    // successfully get a screenshot, but it was useful for my project.
    generator.maximumSize = CGSizeMake(1000,1000);
    
    CGImageRef cgIm = [generator copyCGImageAtTime:player.currentItem.currentTime
                                        actualTime:&actualTime
                                             error:&error];
    //NSImage *image = [[NSImage alloc] initWithCGImage:cgIm size:(NSSize){ 50.0, 50.0 }];
    NSImage *image = cgImageToNSImage(cgIm);
    CFRelease(cgIm);
    
    if (nil != error) {
        NSLog(@"Error making screenshot: %@", [error localizedDescription]);
        NSLog(@"Actual screenshot time: %f Requested screenshot time: %f", CMTimeGetSeconds(actualTime),
              CMTimeGetSeconds(player.currentItem.currentTime));
        return nil;
    }
    
    NSArray *representations = [image representations];
    NSNumber *compressionFactor = [NSNumber numberWithFloat:0.9];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:compressionFactor
                                                           forKey:NSImageCompressionFactor];
    NSData *data = [NSBitmapImageRep representationOfImageRepsInArray:representations
                                                            usingType:NSJPEGFileType
                                                           properties:imageProps];
    
    return data;
}

- (IBAction)GetPicture:(id)sender {
    if (mVideo) {
        mVideo.photo = [self screenshotFromPlayer:_player];
    }
    
}

- (IBAction)AddChapitre:(id)sender {
    NSArrayController *ptr = [[NSArrayController alloc] init];
    [ptr setManagedObjectContext:self.managedObjectContext];
    [ptr setEntityName:@"Chapitre"];
    [ptr prepareContent];
    
    Chapitre *chapitre = [ptr newObject];
    chapitre.name = @"new chapitre";
    chapitre.photo = [self screenshotFromPlayer:_player];
    chapitre.position = [[NSNumber alloc] initWithDouble: _player.currentItem.currentTime.value];
    chapitre.scale = [[NSNumber alloc] initWithDouble: _player.currentItem.currentTime.timescale];
    [mVideo addHave_chapitreObject:chapitre];
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification{
    Chapitre *chap = [self getCurrent:_ListeChapitre];
    if (chap) {
        [_player.currentItem seekToTime:CMTimeMake([chap.position doubleValue], [chap.scale doubleValue]) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
}

- (void)reloadData {
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    [_ListeChapitre setSortDescriptors:[NSArray arrayWithObject:sort]];
    [self setUrlToPlayer];
}


@end
