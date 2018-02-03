//
//  AppDelegate.m
//  SBTProject
//
//  Created by Сергей Алтухов on 07.01.2018.
//  Copyright © 2018 Сергей Алтухов. All rights reserved.
//

#import "AppDelegate.h"
#import "SBTPersistentContainer.h"
#import "SBTAssembly.h"


@interface AppDelegate ()

@property (nonatomic, strong) SBTAssembly *assembly;

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [UIWindow new];
    self.window.frame = UIScreen.mainScreen.bounds;
    self.window.backgroundColor = UIColor.whiteColor;
    SBTPersistentContainer *persistentContainer = [SBTPersistentContainer new];
    self.assembly = [[SBTAssembly alloc] initWithContext:persistentContainer.persistentContainer.viewContext];
    self.window.rootViewController = [self.assembly createRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
