//
//  RVTAppSettingsService.h
//  RevolutTest
//
//  Created by Nikita Timonin on 12/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Cервис для работы c настройками пользователя.
 */
@interface RVTAppSettingsService : NSObject

/**
 Проверка были ли установлены в первый раз начальные значения валют.

 @return Флаг о наличии все трех валют.
 */
+ (BOOL)currenciesDetermined;

/**
 Установить начальные значения валют.
 */
+ (void)setupInitialCurrencyBalance;

/**
 Получить текущий баланс одной из валют.

 @return Баланс
 */
+ (double)getGBPBalance;
+ (double)getUSDBalance;
+ (double)getEURBalance;

/**
 Сохранить новый баланс одной из валют. 

 @param newAmount Новый баланс
 @param currencyId id валюты
 */
+ (void)setNewAmount: (double) newAmount forCurrency: (NSString *)currencyId;

@end
