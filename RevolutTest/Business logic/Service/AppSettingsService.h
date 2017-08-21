//
//  AppSettingsService.h
//  RevolutTest
//
//  Created by Nikita Timonin on 12/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSettingsService : NSObject

// Set default currency values
+(void)setupInitialCurrencyBalance;

// Get current balance
+(double)getGBPBalance;
+(double)getUSDBalance;
+(double)getEURBalance;

// Set new balance
+(void)setNewAmount: (double) newAmount forCurrency: (NSString *)currencyId;

@end
