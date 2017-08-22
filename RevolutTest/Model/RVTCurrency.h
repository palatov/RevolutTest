//
//  RVTCurrency.h
//  RevolutTest
//
//  Created by Nikita Timonin on 15/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Модель влаюты.
 */
@interface RVTCurrency : NSObject

// id
@property (strong, nonatomic ) NSString *currencyId;
// Курс к евро
@property (nonatomic) double toEur;
// Курс к доллару
@property (nonatomic) double toUSD;
// Курс к фунту
@property (nonatomic) double toGBP;
// Последнее время обновления модели
@property (nonatomic) double lastUpdateTimestamp;
// Символ валюты
@property (strong, nonatomic) NSString *symbol;

-(instancetype)initWith: (NSString *)currencyId
              toEURRate: (double) toEur
              toUSDRate: (double) toUSD
              toGBPRate: (double) toGBP
    lastUpdateTimestamp: (double) timestamp;

/**
 Приведение модели в соотвествие с новыми данными.

 @param newModel Модель с новыми данными
 */
- (void)updateWith: (RVTCurrency *)newModel;

/**
 Получение курса данной валюты ко второй указанной.

 @param currencyId id указанной валюты
 @return Курс валют
 */
- (double)rateForCurrencyWithId: (NSString *)currencyId;

@end
