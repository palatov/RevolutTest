//
//  CurrencyToViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchangeMediator.h"
#import "CurrencyViewController.h"

@interface CurrencyToViewController : UIViewController <CurrencyViewController>

-(instancetype)initWithCurrency:(Currency *)currency mediator: (ExchangeMediator *) mediator;

@end
