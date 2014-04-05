//
//  RADocument.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 09/01/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface RADocument : NSPersistentDocument

- (IBAction)ConfigVideo:(id)sender;
@property (strong) IBOutlet NSCollectionView *ListeVideo;
@property (strong) IBOutlet AVPlayerView *PlayerView;
@property (strong) IBOutlet NSArrayController *ArrayVideo;

- (void)reloadData;

- (void)doubleClick:(id)sender;
- (void)simpleClick:(id)sender;

- (BOOL)configurePersistentStoreCoordinatorForURL:(NSURL*)url
                                           ofType:(NSString*)fileType
                               modelConfiguration:(NSString*)configuration
                                     storeOptions:(NSDictionary*)storeOptions
                                            error:(NSError**)error;
@end
