//
//  RAViewBase.m
//  iVideoLib
//
//  Created by Philippe Fouquet on 11/04/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import "RAViewBase.h"

@interface RAViewBase ()

@end

@implementation RAViewBase

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id) initLoc {
    return nil;
}


- (id)initWithManagedObjectContext:(NSManagedObjectContext *)inMoc : (NSManagedObjectModel*) inMom : (NSPersistentStoreCoordinator *)inPsc
{
	self = [self initLoc];
    
	if(self) {
        [self setManagedObjectContext:inMoc];
        [self setManagedObjectModel:inMom];
        [self setPersistentStoreCoordinator:inPsc];
    }
    
	return self;
}

- (void)setManagedObjectModel:(NSManagedObjectModel *)value
{
	// keep only weak ref
	_mom = value;
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)value
{
	// keep only weak ref
	_moc = value;
}

- (void)setPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)value
{
    _psc = value;
}

- (NSManagedObjectContext *)managedObjectContext
{
	return _moc;
}

- (NSManagedObjectModel *)managedObjectModel
{
    return _mom;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    return _psc;
}

-(id)getCurrent: (NSArrayController *) array{
    if ([[array selectedObjects] count] > 0) {
        return [[array selectedObjects] objectAtIndex:0];
    } else {
        return nil;
    }
}

@end
