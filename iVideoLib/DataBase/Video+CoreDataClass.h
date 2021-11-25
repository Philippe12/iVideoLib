//
//  Video+CoreDataClass.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 24/11/2021.
//  Copyright © 2021 Philippe Fouquet. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Actor, Chapitre;

NS_ASSUME_NONNULL_BEGIN

@interface Video : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Video+CoreDataProperties.h"
