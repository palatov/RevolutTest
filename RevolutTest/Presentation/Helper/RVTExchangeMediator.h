//
//  RVTExchangeMediator.h
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVTCurrency.h"

/**
 Класс отвечаюший за обмен валют.
 */
@interface RVTExchangeMediator : NSObject

// Актуальные модели валют
@property (strong, readonly, nonatomic) NSArray<RVTCurrency *> *currencies;
// Валюта для обмена
@property (strong, nonatomic) RVTCurrency *currencyFrom;
// Валюта в которую производится обмен
@property (strong ,nonatomic) RVTCurrency *currencyTo;
// Количество обменненых денег в новой валюте
@property (nonatomic) double exchangedAmount;
// Флаг возможен ли обмен
@property (nonatomic) BOOL exchangeIsPossible; 

-(instancetype)initWithCurrencies: (NSArray<RVTCurrency *> *)currencies;

/**
 Обновляет модели валют.

 @param currencies Модели с новыми данными
 */
- (void)updateCurrencies: (NSArray<RVTCurrency *> *)currencies;


/**
 Сохраняет результат обмена.
 */
- (void)saveExchangeResult;


/**
 Производит подсчет для обмена.

 @param amount Количество денег сколко нужно поменять
 */
- (void)exchangeCurrencyWithAmmount:(double) amount;


/**
 Получить текущий баланс валюты.
 Может выбросить exception если id не был найден. 

 @param currencyID id Валюты
 @return Баланс
 */
- (double) balanceForCurrencyWithId: (NSString *)currencyID;

@end
