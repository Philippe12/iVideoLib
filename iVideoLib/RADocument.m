//
//  RADocument.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 09/01/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RADocument.h"
#import "RAViewConfigVideo.h"
#import "RAViewConfigActor.h"
#import "RAWindowPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Video+CoreDataClass.h"
#import "Actor+CoreDataClass.h"

@implementation RADocument

- (instancetype)init
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

- (void)awakeFromNib {
    [_videoSidebarOutlineView setFloatsGroupRows:YES];
    [_actorSidebarOutlineView setFloatsGroupRows:YES];
    [NSAnimationContext beginGrouping];
    [NSAnimationContext currentContext].duration = 1000;
    [_videoSidebarOutlineView expandItem:nil expandChildren:NO];
    [_actorSidebarOutlineView expandItem:nil expandChildren:NO];
    [NSAnimationContext endGrouping];
    _videoSidebarOutlineView.doubleAction = @selector(doubleClickInTableView:);
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];
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

- (BOOL)configurePersistentStoreCoordinatorForURL:(NSURL*)url
                                           ofType:(NSString*)fileType
                               modelConfiguration:(NSString*)configuration
                                     storeOptions:(NSDictionary*)storeOptions
                                            error:(NSError**)error
{
    NSMutableDictionary *options = nil;
    if (storeOptions != nil) {
        options = [storeOptions mutableCopy];
    } else {
        options = [[NSMutableDictionary alloc] init];
    }
    
    options[NSMigratePersistentStoresAutomaticallyOption] = @YES;
    
    BOOL result = [super configurePersistentStoreCoordinatorForURL:url
                                                            ofType:fileType
                                                modelConfiguration:configuration
                                                      storeOptions:options
                                                             error:error];
    options = nil;
    return result;
}

- (IBAction)doubleClickInTableView:(id)sender {
    id sel = [[_videoSidebarOutlineView itemAtRow:_videoSidebarOutlineView.selectedRow] representedObject];
    if( sel == nil )
        return;
    
    RAWindowPlayer* wnd = [RAWindowPlayer alloc];
    if( wnd == nil )
        return;
    
    wnd = [wnd initWithManagedObjectContext:self.managedObjectContext :self.managedObjectModel :nil];
    [wnd setPresistent:sel];
    [wnd showWindow:self];

    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    if([outlineView parentForItem:item] == nil)
        return NO;
    return NO;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item{
    bool ret = false;
    ret |= ([[item representedObject] class] == [Video class]);
    ret |= ([[item representedObject] class] == [Actor class]);
    return ret;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item  {
    NSTableCellView *result;
    result = [outlineView makeViewWithIdentifier:@"MyCellVideo" owner:self];
    if( result == nil){
        result = [outlineView makeViewWithIdentifier:@"MyCellActor" owner:self];
    }
    result.objectValue = [item representedObject];
    return result;
}

- (void)_setContentViewToName:(id)item {
    id ptr = nil;
    if (_currentContentViewController) {
        [_currentContentViewController.view removeFromSuperview];
    }
    
    if([item class] == [Video class]) {
        ptr = [RAViewConfigVideo alloc]; // Retained
        if (ptr == nil) {
            return;
        }
        ptr = [ptr initWithManagedObjectContext:self.managedObjectContext :self.managedObjectModel :nil];
        [ptr setPresistent:item];
        [ptr setCallBack:@selector(reloadData)];
    }

    if([item class] == [Actor class]) {
        ptr = [RAViewConfigActor alloc]; // Retained
        if (ptr == nil) {
            return;
        }
        ptr = [ptr initWithManagedObjectContext:self.managedObjectContext :self.managedObjectModel :nil];
        [ptr setPresistent:item];
        [ptr setCallBack:@selector(reloadData)];
    }

    if( ptr != nil){
        _currentContentViewController = ptr;
        NSView *view = _currentContentViewController.view;
        view.frame = _mainContentView.bounds;
        view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        [_mainContentView addSubview:view];
    }
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    NSOutlineView *v = notification.object;
    if (v.selectedRow != -1) {
        id item = [[v itemAtRow:v.selectedRow] representedObject];
        [self _setContentViewToName:item];
    }
}

- (void)reloadData {
    NSSortDescriptor *sortnameVideo = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSSortDescriptor *sortpositionVideo = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    _VideoTree.sortDescriptors = @[sortnameVideo, sortpositionVideo];
    [_videoSidebarOutlineView invalidateIntrinsicContentSize];
    [_videoSidebarOutlineView reloadData];

    NSSortDescriptor *sortnameActor = [[NSSortDescriptor alloc] initWithKey:@"nom" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSSortDescriptor *sortpositionActor = [[NSSortDescriptor alloc] initWithKey:@"prenom" ascending:YES];
    _ActorTree.sortDescriptors = @[sortnameActor, sortpositionActor];
    [_actorSidebarOutlineView invalidateIntrinsicContentSize];
    [_actorSidebarOutlineView reloadData];
}

@end
