//
//  RAViewVideo.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 10/01/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RAViewVideo.h"

@interface RAViewVideo ()

@end

@implementation RAViewVideo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)setSelected:(BOOL)flag {
    [super setSelected:flag];
    NSBox *view = (NSBox*) [self view];
    NSColor *color;
    NSColor *lineColor;
    
    if (flag) {
        color       = [NSColor selectedControlColor];
        lineColor   = [NSColor blackColor];
    } else {
        color       = [NSColor controlBackgroundColor];
        lineColor   = [NSColor controlBackgroundColor];
    }
    
    [view setBorderColor:lineColor];
    [view setFillColor:color];
}

- (void) awakeFromNib {
    NSBox *view = (NSBox*) [self view];
    [view setTitlePosition:NSNoTitle];
    [view setBoxType:NSBoxCustom];
    [view setCornerRadius:8.0];
    [view setBorderType:NSLineBorder];
}

@end
