//
//  Chapitre.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 09/04/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "Chapitre.h"
#import "Video.h"


@implementation Chapitre

@dynamic name;
@dynamic photo;
@dynamic position;
@dynamic scale;
@dynamic for_video;


- (id) have_chapitre
{
    return nil;
}

- (id) locking
{
    return [NSNumber numberWithInt:-1];
}

@end
