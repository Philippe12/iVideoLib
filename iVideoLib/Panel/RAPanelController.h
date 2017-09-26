//
//  RAPanelController.h
//  SortMedia
//
//  Created by Philippe Fouquet on 30/08/13.
//  Copyright (c) 2013 Philippe Fouquet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RAPanelController : NSWindowController {
    NSManagedObjectContext *_moc;
    NSManagedObjectModel *_mom;
    NSPersistentStoreCoordinator *_psc;
}

- (instancetype) initLoc;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)inMoc : (NSManagedObjectModel*) inMom : (NSPersistentStoreCoordinator *)inPsc;

@property (NS_NONATOMIC_IOSONLY, strong) NSManagedObjectContext *managedObjectContext;
@property (NS_NONATOMIC_IOSONLY, copy) NSManagedObjectModel *managedObjectModel;
@property (NS_NONATOMIC_IOSONLY, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (int)runAsPanel: (id)mainWindow;
-(id)getCurrent: (NSArrayController *) array;

- (IBAction)Quite:(id)sender;

@end
