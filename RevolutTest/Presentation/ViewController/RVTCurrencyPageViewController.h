//
//  RVTCurrencyPageViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 13/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVTCurrencyViewController.h"
#import "RVTExchangeMediator.h"

/**
 Базовый контороллер отвечающий за смену валюты. 
 Имеет наследников. 
 */
@interface RVTCurrencyPageViewController : UIPageViewController

// Посредник для обмена.
@property (strong ,nonatomic) RVTExchangeMediator * _Nonnull mediator;
// Текущий контроллер, видимый на экране.
@property (strong, nonatomic) RVTCurrencyViewController * _Nullable currentController;
// Набор контроллеров для перелистывания
@property (strong, nonatomic) NSArray * _Nullable controllers;

- (instancetype _Nonnull )initWithMediator: (RVTExchangeMediator * _Nonnull ) mediator;

@end
