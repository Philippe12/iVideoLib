//
//  Chapitre.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 03/07/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Chapitre, Video;

@interface Chapitre : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSNumber * scale;
@property (nonatomic, retain) NSNumber * locking;
@property (nonatomic, retain) Chapitre *for_chapitre;
@property (nonatomic, retain) Video *for_video;
@property (nonatomic, retain) NSSet *have_chapitre;
@end

@interface Chapitre (CoreDataGeneratedAccessors)

- (void)addHave_chapitreObject:(Chapitre *)value;
- (void)removeHave_chapitreObject:(Chapitre *)value;
- (void)addHave_chapitre:(NSSet *)values;
- (void)removeHave_chapitre:(NSSet *)values;

@end
