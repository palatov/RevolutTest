//
//  RVTExchangeMediator.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTExchangeMediator.h"
#import "RVTAppSettingsService.h"

@interface RVTExchangeMediator ()

@property (nonatomic) double amountToExchange;
@property (nonatomic) double gbpBalance;
@property (nonatomic) double usdBalance;
@property (nonatomic) double eurBalance;

@end

@implementation RVTExchangeMediator

-(instancetype)initWithCurrencies: (NSArray<RVTCurrency *> *)currencies {
    self = [super init];
    _currencies = currencies;
    _currencyFrom = currencies.firstObject;
    _currencyTo = currencies.firstObject;
    _gbpBalance = [RVTAppSettingsService getGBPBalance];
    _eurBalance = [RVTAppSettingsService getEURBalance];
    _usdBalance = [RVTAppSettingsService getUSDBalance];
    return self; 
}

-(void)updateCurrencies:(NSArray<RVTCurrency *> *)currencies {
    for (int i = 0; i < currencies.count; i++) {
        RVTCurrency *newModel = currencies[i];
        RVTCurrency *currentModel = self.currencies[i];
        if ([currentModel.currencyId isEqualToString:newModel.currencyId]) {
            [currentModel updateWith:newModel];
        }
    }
}

-(void)setCurrencyFrom:(RVTCurrency *)currencyFrom {
    _currencyFrom = currencyFrom;
    [self exchangeCurrencyWithAmmount:self.amountToExchange];
}

-(void)setCurrencyTo:(RVTCurrency *)currencyTo {
    _currencyTo = currencyTo;
    [self exchangeCurrencyWithAmmount:self.amountToExchange];
}

-(void)exchangeCurrencyWithAmmount:(double) amount {
    self.amountToExchange = amount;
    self.exchangeIsPossible = [self exchangeIsPossibleForAmount: amount];
    
    double rate = [self.currencyFrom rateForCurrencyWithId:self.currencyTo.currencyId];
    double exchangedAmount = amount *rate;
    self.exchangedAmount = exchangedAmount;
}

-(BOOL)exchangeIsPossibleForAmount: (double) amount {
    if ([self.currencyFrom.currencyId isEqualToString:@"USD"]) {
        return amount <= self.usdBalance;
    } else if ([self.currencyFrom.currencyId isEqualToString:@"EUR"]) {
        return amount <= self.eurBalance;
    } else if ([self.currencyFrom.currencyId isEqualToString:@"GBP"]) {
        return amount <= self.gbpBalance;
    } else {
        return false;
    }
}

-(double) balanceForCurrencyWithId: (NSString *)currencyId {
    if ([currencyId isEqualToString:@"GBP"]){
        return self.gbpBalance;
    } else if ([currencyId isEqualToString:@"EUR"]) {
        return self.eurBalance;
    } else if ([currencyId isEqualToString:@"USD"]){
        return self.usdBalance;
    } else {
        NSException* exception = [NSException
                                    exceptionWithName:@""
                                    reason: [NSString stringWithFormat:@"Валюта с ID %@ не найдена",currencyId]
                                    userInfo:nil];
        @throw exception;
    }
}

-(void)saveExchangeResult {
    
    if ([self.currencyTo.currencyId isEqualToString:self.currencyFrom.currencyId]) {
        return ;
    }
    
    double fromBalance = [self balanceForCurrencyWithId:self.currencyFrom.currencyId];
    double newFromBalance = fromBalance - self.amountToExchange;
    [RVTAppSettingsService setNewAmount:newFromBalance forCurrency:self.currencyFrom.currencyId];
    
    double toBalance = [self balanceForCurrencyWithId:self.currencyTo.currencyId];
    double newToBalance = toBalance + self.exchangedAmount;
    [RVTAppSettingsService setNewAmount:newToBalance forCurrency:self.currencyTo.currencyId];
    
    self.gbpBalance = [RVTAppSettingsService getGBPBalance];
    self.eurBalance = [RVTAppSettingsService getEURBalance];
    self.usdBalance = [RVTAppSettingsService getUSDBalance];
    
     self.exchangeIsPossible = [self exchangeIsPossibleForAmount: self.amountToExchange];
}

@end
