//
//  RVTCurrencyViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 22/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVTCurrency.h"
#import "RVTExchangeMediator.h"

@interface RVTCurrencyViewController : UIViewController

@property (readonly, strong, nonatomic) RVTCurrency *currency;
@property (readonly, strong, nonatomic) RVTExchangeMediator *mediator;
-(instancetype)initWithCurrency:(RVTCurrency *)currency mediator: (RVTExchangeMediator *) mediator;

@end
