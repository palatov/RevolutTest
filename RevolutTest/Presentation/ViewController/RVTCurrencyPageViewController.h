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

@interface RVTCurrencyPageViewController : UIPageViewController

// TODO: - cделать оба эти проперти доступными для записи только изнутри
@property (strong ,nonatomic) RVTExchangeMediator * _Nonnull mediator;
@property (strong, nonatomic) RVTCurrencyViewController * _Nullable currentController;
@property (strong, nonatomic) NSArray * _Nullable controllers;

- (instancetype _Nonnull )initWithMediator: (RVTExchangeMediator * _Nonnull ) mediator;

@end
