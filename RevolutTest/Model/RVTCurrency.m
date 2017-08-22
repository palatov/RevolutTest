//
//  RVTCurrency.m
//  RevolutTest
//
//  Created by Nikita Timonin on 15/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrency.h"

@implementation RVTCurrency

- (instancetype)initWith: (NSString *)currencyId
              toEURRate: (double) toEur
              toUSDRate: (double) toUSD
              toGBPRate: (double) toGBP
    lastUpdateTimestamp: (double) timestamp{
    self = [super init];
    self.currencyId = currencyId;
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: currencyId];
    NSString *currencySymbol = [locale displayNameForKey:NSLocaleCurrencySymbol
                                                   value:currencyId];
    self.symbol = [NSString stringWithFormat:@"%@", currencySymbol];
    self.toEur = toEur;
    self.toGBP = toGBP;
    self.toUSD = toUSD;
    self.lastUpdateTimestamp = timestamp;
    return self;
}

- (double)rateForCurrencyWithId: (NSString *)currencyId {
    if ([currencyId isEqualToString:@"GBP"]){
        return self.toGBP;
    } else if ([currencyId isEqualToString:@"EUR"]) {
        return self.toEur;
    } else if ([currencyId isEqualToString:@"USD"]){
        return self.toUSD;
    } else {
        
        NSString *reason = [NSString stringWithFormat:@"Валюта с ID %@ не найдена",currencyId];
        NSException* exception = [NSException
                                  exceptionWithName:@""
                                  reason:reason
                                  userInfo:nil];
        @throw exception;
    }
}

- (void)updateWith: (RVTCurrency *)newModel {
    self.toEur = newModel.toEur;
    self.toGBP = newModel.toGBP;
    self.toUSD = newModel.toUSD;
    self.lastUpdateTimestamp = newModel.lastUpdateTimestamp;
}

@end
