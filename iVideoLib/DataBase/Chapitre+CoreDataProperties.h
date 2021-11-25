//
//  Chapitre+CoreDataProperties.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 24/11/2021.
//  Copyright © 2021 Philippe Fouquet. All rights reserved.
//
//

#import "Chapitre+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Chapitre (CoreDataProperties)

+ (NSFetchRequest<Chapitre *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSNumber *locking;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, copy) NSNumber *position;
@property (nullable, nonatomic, copy) NSNumber *scale;
@property (nullable, nonatomic, copy) NSNumber *time;
@property (nullable, nonatomic, retain) Chapitre *for_chapitre;
@property (nullable, nonatomic, retain) Video *for_video;
@property (nullable, nonatomic, retain) NSSet<Chapitre *> *have_chapitre;

@end

@interface Chapitre (CoreDataGeneratedAccessors)

- (void)addHave_chapitreObject:(Chapitre *)value;
- (void)removeHave_chapitreObject:(Chapitre *)value;
- (void)addHave_chapitre:(NSSet<Chapitre *> *)values;
- (void)removeHave_chapitre:(NSSet<Chapitre *> *)values;

@end

NS_ASSUME_NONNULL_END
