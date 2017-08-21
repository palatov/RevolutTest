//
//  CurrencyFromViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchangeMediator.h"
#import "Currency.h"
#import "CurrencyViewController.h"

@interface CurrencyFromViewController : UIViewController < CurrencyViewController >

// TODO - cделать currency приватным для записи из вне
@property (weak, nonatomic) IBOutlet UITextField *textField;
-(instancetype)initWithCurrency:(Currency *)currency mediator: (ExchangeMediator *) mediator;

@end
