//
//  Chapitre+CoreDataProperties.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 24/11/2021.
//  Copyright © 2021 Philippe Fouquet. All rights reserved.
//
//

#import "Chapitre+CoreDataProperties.h"

@implementation Chapitre (CoreDataProperties)

+ (NSFetchRequest<Chapitre *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Chapitre"];
}

@dynamic locking;
@dynamic name;
@dynamic photo;
@dynamic position;
@dynamic scale;
@dynamic time;
@dynamic for_chapitre;
@dynamic for_video;
@dynamic have_chapitre;

@end
