//
//  ExchangeMediator.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "ExchangeMediator.h"
#import "AppSettingsService.h"

@interface ExchangeMediator ()

@property (nonatomic) double amountToExchange;
@property (nonatomic) double gbpBalance;
@property (nonatomic) double usdBalance;
@property (nonatomic) double eurBalance;

@end

@implementation ExchangeMediator

-(instancetype)initWithCurrencies: (NSArray<Currency *> *)currencies {
    self = [super init];
    _currencies = currencies;
    _currencyFrom = currencies.firstObject;
    _currencyTo = currencies.firstObject;
    _gbpBalance = [AppSettingsService getGBPBalance];
    _eurBalance = [AppSettingsService getEURBalance];
    _usdBalance = [AppSettingsService getUSDBalance];
    return self; 
}

-(void)updateCurrencies:(NSArray<Currency *> *)currencies {
    for (int i = 0; i < currencies.count; i++) {
        Currency *newModel = currencies[i];
        Currency *currentModel = self.currencies[i];
        if ([currentModel.currencyId isEqualToString:newModel.currencyId]) {
            [currentModel updateWith:newModel];
        }
    }
}

-(void)setCurrencyFrom:(Currency *)currencyFrom {
    _currencyFrom = currencyFrom;
    [self exchangeCurrencyWithAmmount:self.amountToExchange];
}

-(void)setCurrencyTo:(Currency *)currencyTo {
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
    [AppSettingsService setNewAmount:newFromBalance forCurrency:self.currencyFrom.currencyId];
    
    double toBalance = [self balanceForCurrencyWithId:self.currencyTo.currencyId];
    double newToBalance = toBalance + self.exchangedAmount;
    [AppSettingsService setNewAmount:newToBalance forCurrency:self.currencyTo.currencyId];
    
    self.gbpBalance = [AppSettingsService getGBPBalance];
    self.eurBalance = [AppSettingsService getEURBalance];
    self.usdBalance = [AppSettingsService getUSDBalance];
    
     self.exchangeIsPossible = [self exchangeIsPossibleForAmount: self.amountToExchange];
}

@end
