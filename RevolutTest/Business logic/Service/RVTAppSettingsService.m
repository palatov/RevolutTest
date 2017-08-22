//
//  RVTAppSettingsService.m
//  RevolutTest
//
//  Created by Nikita Timonin on 12/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTAppSettingsService.h"
#import "RVTConstants.h"

@implementation RVTAppSettingsService

// Set default currency values
+(void)setupInitialCurrencyBalance {
    [[NSUserDefaults standardUserDefaults] setDouble:100 forKey:USD];
    [[NSUserDefaults standardUserDefaults] setDouble:100 forKey:GBP];
    [[NSUserDefaults standardUserDefaults] setDouble:100 forKey:EUR];
}

// Get current balance
+(double)getGBPBalance {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:GBP];
}

+(double)getUSDBalance {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:USD];
}

+(double)getEURBalance {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:EUR];
}

// Set new balance
+(void)setNewAmount:(double)newAmount forCurrency:(NSString *)currencyId {
    [[NSUserDefaults standardUserDefaults] setDouble:newAmount forKey:currencyId];
}


@end
