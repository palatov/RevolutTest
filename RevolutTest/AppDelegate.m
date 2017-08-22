//
//  AppDelegate.m
//  RevolutTest
//
//  Created by Nikita Timonin on 12/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "AppDelegate.h"
#import "RVTAppSettingsService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /**
     Initial currency balance 
     EUR: 100
     GBP: 100
     USD: 100
    */
    
    // TODO: - добавить здесь проверку на первый запуск
    [RVTAppSettingsService setupInitialCurrencyBalance];
    return YES;
}

@end
