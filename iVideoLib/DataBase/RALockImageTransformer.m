//
//  RALockImageTransformer.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 05/04/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RALockImageTransformer.h"

@implementation RALockImageTransformer

+(Class)transformedValueClass {
    return [NSImage class];
}

-(id)transformedValue:(id)value {
    NSNumber *tmp = value;
    NSImage *ret = nil;
    if( [tmp isEqualTo:[NSNumber numberWithInt:1]]) {
        ret = [NSImage imageNamed:@"NSLockLockedTemplate"];
    }
    else {
        ret = [NSImage imageNamed:@"NSLockUnlockedTemplate"];
    }
        
    return ret;
}

@end
