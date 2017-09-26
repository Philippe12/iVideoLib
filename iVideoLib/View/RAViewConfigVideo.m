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
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];
}

- (void)setUrlToPlayer {
    bool erasevideo = true;
    if (mVideo) {
        if( mVideo.url != nil )
        {
            erasevideo = false;
            NSURL *url = [NSURL URLWithString:mVideo.url];
            if( ![url isEqualTo:loadingVideo]) {
                loadingVideo = url;
                _player = [AVPlayer playerWithURL:url];
                self.PlayerView.player = _player;
            }
        }
    }
    if (erasevideo) {
        self.PlayerView.player = nil;
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
    NSString *wildcardedString = [NSString stringWithFormat:@"%@", value];
    
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
    generator.appliesPreferredTrackTransform=TRUE;
    generator.apertureMode = AVAssetImageGeneratorApertureModeCleanAperture;
    generator.requestedTimeToleranceBefore = kCMTimeZero;
    generator.requestedTimeToleranceAfter = kCMTimeZero;
    
    CGImageRef cgIm = [generator copyCGImageAtTime:player.currentItem.currentTime
                                        actualTime:&actualTime
                                             error:&error];
    
    if (nil != error) {
        NSLog(@"Error making screenshot: %@", [error localizedDescription]);
        NSLog(@"Actual screenshot time: %f Requested screenshot time: %f", CMTimeGetSeconds(actualTime),
              CMTimeGetSeconds(player.currentItem.currentTime));
        return nil;
    }

    //NSImage *image = [[NSImage alloc] initWithCGImage:cgIm size:(NSSize){ 50.0, 50.0 }];
    NSImage *image = cgImageToNSImage(cgIm);
    if( cgIm != nil ) {
        CFRelease(cgIm);
    }
    
    NSArray *representations = [image representations];
    NSNumber *compressionFactor = [NSNumber numberWithFloat:0.9];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:compressionFactor
                                                           forKey:NSImageCompressionFactor];
    NSData *data = [NSBitmapImageRep representationOfImageRepsInArray:representations
                                                            usingType:NSPNGFileType
                                                           properties:imageProps];
    
    return data;
}

- (IBAction)GetPicture:(id)sender {
    if (mVideo) {
        mVideo.photo = [self screenshotFromPlayer:_player];
    }
    
}

- (NSIndexPath*)indexPathOfObject:(id)anObject
{
    return [self indexPathOfObject:anObject inNodes:[[_ChapitreTree arrangedObjects] childNodes]];
}

- (NSIndexPath*)indexPathOfObject:(id)anObject inNodes:(NSArray*)nodes
{
    for(NSTreeNode* node in nodes)
    {
        if([[node representedObject] isEqual:anObject])
            return [node indexPath];
        if([[node childNodes] count])
        {
            NSIndexPath* path = [self indexPathOfObject:anObject inNodes:[node childNodes]];
            if(path)
                return path;
        }
    }
    return nil;
}

- (IBAction)AddChapitre:(id)sender {
    NSArrayController *ptr = [self creatArray:@"Chapitre"];

    if(ptr) {
        Chapitre *chapitre = [ptr newObject];
        chapitre.name = @"new chapitre";
        chapitre.photo = [self screenshotFromPlayer:_player];
        chapitre.position = [[NSNumber alloc] initWithDouble: _player.currentItem.currentTime.value];
        chapitre.scale = [[NSNumber alloc] initWithDouble: _player.currentItem.currentTime.timescale];
        chapitre.time = [[NSNumber alloc] initWithDouble:
                     [chapitre.position doubleValue] / [chapitre.scale doubleValue] ];
        [mVideo addHave_chapitreObject:chapitre];
        [_ChapitreTree setSelectionIndexPath:[self indexPathOfObject:chapitre]];
        [self runCallback:0];
    }
}

- (IBAction)RemoveChapitre:(id)sender {
    NSArrayController *ptr = [self creatArray:@"Chapitre"];
    if (ptr) {
        Chapitre *chap = nil;
        if ([_Outline selectedRow] != -1)
            chap = [[_Outline itemAtRow:[_Outline selectedRow]] representedObject];
        if (chap) {
            [ptr removeObject:chap];
            [self runCallback:0];
        }
    }

    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    Chapitre *chap = nil;
    if ([_Outline selectedRow] != -1)
        chap = [[_Outline itemAtRow:[_Outline selectedRow]] representedObject];
    if (chap) {
        [_player.currentItem seekToTime:CMTimeMake([chap.position doubleValue], [chap.scale doubleValue]) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id < NSDraggingInfo >)info item:(id)item childIndex:(NSInteger)index {
    //NSLog(@"accepting drag operation");
    //todo: move the object in the data model;
    //NSIndexPath *path = [_ChapitreTree selectionIndexPath]; // these three values are nil too.
    //NSArray *objects = [_ChapitreTree selectedObjects];
    //NSArray *nodes = [_ChapitreTree selectedNodes];
    //NSLog(@"%@", path);
    //NSLog(@"%@", objects);
    //NSLog(@"%@", nodes);
    return YES;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView writeItems:(NSArray *)items toPasteboard:(NSPasteboard *)pboard {
    NSString *pasteBoardType = @"Event";
    [pboard declareTypes:[NSArray arrayWithObject:pasteBoardType] owner:self];
    
    return YES;
}

- (NSDragOperation)outlineView:(NSOutlineView *)outlineView
                  validateDrop:(id < NSDraggingInfo >)info
                  proposedItem:(id)item
            proposedChildIndex:(NSInteger)index {
    return NSDragOperationGeneric;
}

// This method gets called by the framework but the values from bindings are used instead
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    return NULL;
}

- (void)reloadData {
    [_Outline registerForDraggedTypes:[NSArray arrayWithObject: @"Event"]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    [_ChapitreTree setSortDescriptors:[NSArray arrayWithObject:sort]];
    [self setUrlToPlayer];
    [_Outline reloadData];
}


@end
