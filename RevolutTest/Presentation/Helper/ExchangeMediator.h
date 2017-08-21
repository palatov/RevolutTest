//
//  ExchangeMediator.h
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface ExchangeMediator : NSObject

@property (strong, readonly, nonatomic) NSArray<Currency *> *currencies;

@property (strong, nonatomic) Currency *currencyFrom;
@property (strong ,nonatomic) Currency *currencyTo;
@property (nonatomic) double exchangedAmount;
@property (nonatomic) BOOL exchangeIsPossible; 

// Cчитает деньги

-(instancetype)initWithCurrencies: (NSArray<Currency *> *)currencies;
-(void)updateCurrencies: (NSArray<Currency *> *)currencies;
-(void)saveExchangeResult;
-(void)exchangeCurrencyWithAmmount:(double) amount;
-(double) balanceForCurrencyWithId: (NSString *)currencyID;

@end
