//
//  RADurationTransformer.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 13/03/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RADurationTransformer.h"
#import <AVFoundation/AVFoundation.h>

@implementation RADurationTransformer

+(Class)transformedValueClass {
    return [NSString class];
}

-(id)transformedValue:(id)value {
    // Return variable.
    NSString *result = @"";
    
    // Int variables for calculation.
    int secs = [value intValue];
    int tempHour    = 0;
    int tempMinute  = 0;
    int tempSecond  = 0;
    
    NSString *hour      = @"";
    NSString *minute    = @"";
    NSString *second    = @"";
    
    // Convert the seconds to hours, minutes and seconds.
    tempHour    = secs / 3600;
    tempMinute  = (secs / 60) - (tempHour * 60);
    tempSecond  = secs - ((tempHour * 3600) + (tempMinute * 60));
    
    hour    = [[NSNumber numberWithInt:tempHour] stringValue];
    minute  = [[NSNumber numberWithInt:tempMinute] stringValue];
    second  = [[NSNumber numberWithInt:tempSecond] stringValue];
    
    // Make time look like 00:00:00 and not 0:0:0
    if (tempHour < 10) {
        hour = [@"0" stringByAppendingString:hour];
    }
    
    if (tempMinute < 10) {
        minute = [@"0" stringByAppendingString:minute];
    }
    
    if (tempSecond < 10) {
        second = [@"0" stringByAppendingString:second];
    }
    
    if (tempHour == 0) {
        
        //NSLog(@"Result of Time Conversion: %@:%@", minute, second);
        result = [NSString stringWithFormat:@"%@:%@", minute, second];
        
    } else {
        
        //NSLog(@"Result of Time Conversion: %@:%@:%@", hour, minute, second);
        result = [NSString stringWithFormat:@"%@:%@:%@",hour, minute, second];
        
    }
    
    return result;
}

@end
