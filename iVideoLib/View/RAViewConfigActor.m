//
//  RAViewConfigActor.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 11/04/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RAViewConfigActor.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "Actor+CoreDataClass.h"

@interface RAViewConfigActor ()

@property AVPlayer *player;

@end

@implementation RAViewConfigActor

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (instancetype)initLoc 
{
    self = [super initWithNibName:@"RAViewConfigActor" bundle:nil];
    return self;
}

- (void)setPresistent:(id)val
{
    mActor = val;
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0];
}

/*- (NSIndexPath*)indexPathOfObject:(id)anObject
{
    return [self indexPathOfObject:anObject inNodes:_ChapitreTree.arrangedObjects.childNodes];
}*/

- (NSIndexPath*)indexPathOfObject:(id)anObject inNodes:(NSArray*)nodes
{
    for(NSTreeNode* node in nodes)
    {
        if([node.representedObject isEqual:anObject])
            return node.indexPath;
        if(node.childNodes.count)
        {
            NSIndexPath* path = [self indexPathOfObject:anObject inNodes:node.childNodes];
            if(path)
                return path;
        }
    }
    return nil;
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
    [pboard declareTypes:@[pasteBoardType] owner:self];
    
    return YES;
}

- (NSDragOperation)outlineView:(NSOutlineView *)outlineView
                  validateDrop:(id < NSDraggingInfo >)info
                  proposedItem:(id)item
            proposedChildIndex:(NSInteger)index {
    return NSDragOperationGeneric;
}

// This method gets called by the framework but the values from bindings are used instead
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
    return NULL;
}

- (void)reloadData {
    //[_Outline registerForDraggedTypes:@[@"Event"]];
    //NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    //_ChapitreTree.sortDescriptors = @[sort];
    //[self setUrlToPlayer];
    //[_Outline reloadData];
}


@end
