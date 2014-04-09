//
//  Chapitre.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 09/04/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Video;

@interface Chapitre : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSNumber * scale;
@property (nonatomic, retain) Video *for_video;

@end
