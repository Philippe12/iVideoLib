//
//  RAViewBase.h
//  iVideoLib
//
//  Created by Philippe Fouquet on 11/04/2014.
//  Copyright (c) 2014 Philippe Fouquet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RAViewBase : NSViewController {
    NSManagedObjectContext *_moc;
    NSManagedObjectModel *_mom;
    NSPersistentStoreCoordinator *_psc;
    SEL callBack_fonc;
}

- (instancetype) initLoc;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)inMoc : (NSManagedObjectModel*) inMom : (NSPersistentStoreCoordinator *)inPsc;


@property (NS_NONATOMIC_IOSONLY, strong) NSManagedObjectContext *managedObjectContext;
@property (NS_NONATOMIC_IOSONLY, copy) NSManagedObjectModel *managedObjectModel;
@property (NS_NONATOMIC_IOSONLY, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(id)getCurrent: (NSArrayController *) array;
-(NSArrayController *) creatArray: (NSString *) entity;

- (void) setCallBack:(SEL)fonc;
- (void) runCallback:(int) delay;

@end
