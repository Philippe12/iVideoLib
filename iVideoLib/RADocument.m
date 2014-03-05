//
//  RADocument.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 09/01/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RADocument.h"
#import "RAConfigVideo.h"
#import "RAWindowPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation RADocument

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"RADocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (void)reloadData {
//    [self.managedObjectModel invalidate];
//    [_ListeVideo invalidate];
//    [_ListeVideo releaseGState];
}

- (IBAction)ConfigVideo:(id)sender {
    id sel = [[_ListeVideo itemAtIndex:[[_ListeVideo selectionIndexes] firstIndex]] representedObject];
    if( sel == nil )
        return;
    
    id wnd = [RAConfigVideo alloc];
    if( wnd == nil )
        return;
    
    wnd = [wnd initWithManagedObjectContext:self.managedObjectContext :self.managedObjectModel :nil];
    [wnd setPresistent:sel];
    [wnd runAsPanel:self.windowForSheet];
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];
}

- (void)doubleClick:(id)sender {
    id sel = [[_ListeVideo itemAtIndex:[[_ListeVideo selectionIndexes] firstIndex]] representedObject];
    if( sel == nil )
        return;
    
    RAWindowPlayer* wnd = [[RAWindowPlayer alloc] initLoc];
    if( wnd == nil )
        return;
    [wnd setPresistent:sel];
    [wnd showWindow:self];
    
}

- (void)simpleClick:(id)sender {
/*    Video *sel = [[_ListeVideo itemAtIndex:[[_ListeVideo selectionIndexes] firstIndex]] representedObject];
    
    if (sel) {
        if( sel.url != nil )
        {
            NSURL *url = [NSURL URLWithString:sel.url];
            self.PlayerView.player = nil;
            AVPlayer *player = [AVPlayer playerWithURL:url];
            self.PlayerView.player = player;
        }
    }*/
}

@end
