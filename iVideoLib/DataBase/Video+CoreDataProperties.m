//
//  Video+CoreDataProperties.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 24/11/2021.
//  Copyright © 2021 Philippe Fouquet. All rights reserved.
//
//

#import "Video+CoreDataProperties.h"

@implementation Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Video"];
}

@dynamic lenght;
@dynamic locking;
@dynamic name;
@dynamic photo;
@dynamic url;
@dynamic have_chapitre;
@dynamic have_actor;

@end
