//
//  AppDelegate.m
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import "AppDelegate.h"
#import "GameModeSelectorViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    GameModeSelectorViewController *gameModeSelector = [GameModeSelectorViewController initFromXib];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:gameModeSelector];
    nav.navigationBar.tintColor = [UIColor colorWithRed:0.40 green:0.06 blue:0.95 alpha:1.0];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.40 green:0.06 blue:0.95 alpha:1.0]};
    nav.navigationBar.translucent = false;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
