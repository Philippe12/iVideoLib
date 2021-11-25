//
//  Actor+CoreDataProperties.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 24/11/2021.
//  Copyright © 2021 Philippe Fouquet. All rights reserved.
//
//

#import "Actor+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Actor (CoreDataProperties)

+ (NSFetchRequest<Actor *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *prenom;
@property (nullable, nonatomic, copy) NSString *nom;
@property (nullable, nonatomic, copy) NSNumber *naissance;
@property (nullable, nonatomic, copy) NSString *nationnalite;
@property (nullable, nonatomic, copy) NSString *cheveux;
@property (nullable, nonatomic, copy) NSNumber *sexe;
@property (nullable, nonatomic, copy) NSNumber *taille;
@property (nullable, nonatomic, copy) NSNumber *poid;
@property (nullable, nonatomic, copy) NSNumber *tourdepoitrine;
@property (nullable, nonatomic, copy) NSNumber *tourdeshanche;
@property (nullable, nonatomic, copy) NSNumber *tourdetaille;
@property (nullable, nonatomic, copy) NSString *bonnet;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, copy) NSString *yeux;
@property (nullable, nonatomic, retain) NSSet<Video *> *in_video;

@end

@interface Actor (CoreDataGeneratedAccessors)

- (void)addIn_videoObject:(Video *)value;
- (void)removeIn_videoObject:(Video *)value;
- (void)addIn_video:(NSSet<Video *> *)values;
- (void)removeIn_video:(NSSet<Video *> *)values;

@end

NS_ASSUME_NONNULL_END
