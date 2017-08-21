//
//  CurrencyPageViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 13/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"
#import "CurrencyViewController.h"
#import "ExchangeMediator.h"

@interface CurrencyPageViewController : UIPageViewController

// TODO: - cделать оба эти проперти доступными для записи только изнутри
@property (strong ,nonatomic) ExchangeMediator * _Nonnull mediator;
@property (strong, nonatomic) id<CurrencyViewController> _Nullable currentController;
@property (strong, nonatomic) NSArray * _Nullable controllers;

- (instancetype _Nonnull )initWithMediator: (ExchangeMediator * _Nonnull ) mediator;

@end
