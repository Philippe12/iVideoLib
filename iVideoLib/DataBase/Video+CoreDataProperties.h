//
//  Video+CoreDataProperties.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 24/11/2021.
//  Copyright © 2021 Philippe Fouquet. All rights reserved.
//
//

#import "Video+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Video (CoreDataProperties)

+ (NSFetchRequest<Video *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSNumber *lenght;
@property (nullable, nonatomic, copy) NSNumber *locking;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) NSSet<Chapitre *> *have_chapitre;
@property (nullable, nonatomic, retain) NSSet<Actor *> *have_actor;

@end

@interface Video (CoreDataGeneratedAccessors)

- (void)addHave_chapitreObject:(Chapitre *)value;
- (void)removeHave_chapitreObject:(Chapitre *)value;
- (void)addHave_chapitre:(NSSet<Chapitre *> *)values;
- (void)removeHave_chapitre:(NSSet<Chapitre *> *)values;

- (void)addHave_actorObject:(Actor *)value;
- (void)removeHave_actorObject:(Actor *)value;
- (void)addHave_actor:(NSSet<Actor *> *)values;
- (void)removeHave_actor:(NSSet<Actor *> *)values;

@end

NS_ASSUME_NONNULL_END
