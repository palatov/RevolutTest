//
//  RVTExchangeMediator.h
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVTCurrency.h"

@interface RVTExchangeMediator : NSObject

@property (strong, readonly, nonatomic) NSArray<RVTCurrency *> *currencies;

@property (strong, nonatomic) RVTCurrency *currencyFrom;
@property (strong ,nonatomic) RVTCurrency *currencyTo;
@property (nonatomic) double exchangedAmount;
@property (nonatomic) BOOL exchangeIsPossible; 

// Cчитает деньги

-(instancetype)initWithCurrencies: (NSArray<RVTCurrency *> *)currencies;
-(void)updateCurrencies: (NSArray<RVTCurrency *> *)currencies;
-(void)saveExchangeResult;
-(void)exchangeCurrencyWithAmmount:(double) amount;
-(double) balanceForCurrencyWithId: (NSString *)currencyID;

@end
