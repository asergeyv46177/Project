//
//  SBTPersistentContainer.m
//  SBTProject
//
//  Created by Sergey Altukhov on 22.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "SBTPersistentContainer.h"


@implementation SBTPersistentContainer

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SBTProject"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

@end
