//
//  RADocument.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 09/01/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RADocument.h"
#import "RAViewConfigVideo.h"
#import "RAWindowPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

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
    [_sidebarOutlineView setFloatsGroupRows:YES];
    [NSAnimationContext beginGrouping];
    [NSAnimationContext currentContext].duration = 1000;
    [_sidebarOutlineView expandItem:nil expandChildren:NO];
    [NSAnimationContext endGrouping];
    _sidebarOutlineView.doubleAction = @selector(doubleClickInTableView:);
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
    id sel = [[_sidebarOutlineView itemAtRow:_sidebarOutlineView.selectedRow] representedObject];
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
    return ([[item representedObject] class] == [Video class]);
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item  {
    NSTableCellView *result = [outlineView makeViewWithIdentifier:@"MyCell" owner:self];
    result.objectValue = [item representedObject];
    return result;
}

- (void)_setContentViewToName:(id)item {
    if (_currentContentViewController) {
        [_currentContentViewController.view removeFromSuperview];
    }
    
    id ptr = [RAViewConfigVideo alloc]; // Retained
    if (ptr == nil) {
        return;
    }
    ptr = [ptr initWithManagedObjectContext:self.managedObjectContext :self.managedObjectModel :nil];
    [ptr setPresistent:item];
    [ptr setCallBack:@selector(reloadData)];
    _currentContentViewController = ptr;
    
    NSView *view = _currentContentViewController.view;
    view.frame = _mainContentView.bounds;
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [_mainContentView addSubview:view];
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    if (_sidebarOutlineView.selectedRow != -1) {
        id item = [[_sidebarOutlineView itemAtRow:_sidebarOutlineView.selectedRow] representedObject];
        [self _setContentViewToName:item];
    }
}

- (void)reloadData {
    NSSortDescriptor *sortname = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSSortDescriptor *sortposition = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
    _VideoTree.sortDescriptors = @[sortname, sortposition];
    [_sidebarOutlineView invalidateIntrinsicContentSize];
    [_sidebarOutlineView reloadData];
}

@end
