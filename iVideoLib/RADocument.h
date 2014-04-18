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

@interface RADocument : NSPersistentDocument <NSOutlineViewDelegate> {
    //NSViewController *_currentContentViewController;
    id _currentContentViewController;
}

@property (strong) IBOutlet NSOutlineView *sidebarOutlineView;
@property (strong) IBOutlet NSTreeController *VideoTree;
@property (strong) IBOutlet NSView *mainContentView;

- (void)reloadData;

- (BOOL)configurePersistentStoreCoordinatorForURL:(NSURL*)url
                                           ofType:(NSString*)fileType
                               modelConfiguration:(NSString*)configuration
                                     storeOptions:(NSDictionary*)storeOptions
                                            error:(NSError**)error;
@end
