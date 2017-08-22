//
//  RVTCurrencyService.h
//  RevolutTest
//
//  Created by Nikita Timonin on 12/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVTCurrency.h"

/**
 Сервис отвечающий за загрузку и парсинг курсов валют
 */
@interface RVTCurrencyService : NSObject

// Блок успешного завершения
typedef void(^completionBlock)(NSArray<RVTCurrency *> *);

// Блок ошибки
typedef void(^errorHandler)(NSError *error);

- (instancetype)initWithCompletionBlock: (completionBlock) block errorHandler: (errorHandler) handler;

/**
 Запрос курса валют. Первый раз вызвается из вне. 
 В последущий разы внутри сервиса через интервал. 
 Смотри приватный метод scheduleNextCurrencyUpdate. 
 */
- (void)updateCurrencies;

@end
