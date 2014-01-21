//
//  RAEnabledTranformer.m
//  SortMedia
//
//  Created by Philippe Fouquet on 16/05/13.
//  Copyright (c) 2013 Philippe Fouquet. All rights reserved.
//

#import "RAEnabledTranformer.h"

@implementation RAEnabledTranformer

+(Class)transformedValueClass {
    return [NSNumber class];
}

-(id)transformedValue:(id)value {
    NSString *tmp = value;
    NSNumber *ret = [[NSNumber alloc] initWithBool:[tmp length]!=0];
    return ret;
}

@end
