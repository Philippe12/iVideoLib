//
//  Actor+CoreDataProperties.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 24/11/2021.
//  Copyright © 2021 Philippe Fouquet. All rights reserved.
//
//

#import "Actor+CoreDataProperties.h"

@implementation Actor (CoreDataProperties)

+ (NSFetchRequest<Actor *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Actor"];
}

@dynamic prenom;
@dynamic nom;
@dynamic naissance;
@dynamic nationnalite;
@dynamic cheveux;
@dynamic sexe;
@dynamic taille;
@dynamic poid;
@dynamic tourdepoitrine;
@dynamic tourdeshanche;
@dynamic tourdetaille;
@dynamic bonnet;
@dynamic photo;
@dynamic yeux;
@dynamic in_video;

@end
