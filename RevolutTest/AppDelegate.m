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
     Начальный баланс
     EUR: 100
     GBP: 100
     USD: 100
    */
    
    // Проверка были ли валюты уже установлены в значение по умолчанию
    if (![RVTAppSettingsService currenciesDetermined]) {
        [RVTAppSettingsService setupInitialCurrencyBalance];
    }
    
    return YES;
}

@end
