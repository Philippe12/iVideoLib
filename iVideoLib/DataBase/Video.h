//
//  Video.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 09/01/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Video : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSSet *have_chapitre;
@end

@interface Video (CoreDataGeneratedAccessors)

- (void)addHave_chapitreObject:(NSManagedObject *)value;
- (void)removeHave_chapitreObject:(NSManagedObject *)value;
- (void)addHave_chapitre:(NSSet *)values;
- (void)removeHave_chapitre:(NSSet *)values;

@end
