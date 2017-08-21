//
//  AppSettingsService.m
//  RevolutTest
//
//  Created by Nikita Timonin on 12/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "AppSettingsService.h"

@implementation AppSettingsService

static NSString *lastUpdateDate = @"lastUpdateDate";
static NSString *usd = @"USD";
static NSString *gbp = @"GBP";
static NSString *eur = @"EUR";


// Set default currency values
+(void)setupInitialCurrencyBalance {
    [[NSUserDefaults standardUserDefaults] setDouble:100 forKey:usd];
    [[NSUserDefaults standardUserDefaults] setDouble:100 forKey:gbp];
    [[NSUserDefaults standardUserDefaults] setDouble:100 forKey:eur];
}

// Get current balance
+(double)getGBPBalance {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:gbp];
}

+(double)getUSDBalance {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:usd];
}

+(double)getEURBalance {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:eur];
}

// Set new balance
+(void)setNewAmount:(double)newAmount forCurrency:(NSString *)currencyId {
    [[NSUserDefaults standardUserDefaults] setDouble:newAmount forKey:currencyId];
}


@end
