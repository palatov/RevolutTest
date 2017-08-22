//
//  RVTCurrencyFromViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVTExchangeMediator.h"
#import "RVTCurrency.h"
#import "RVTCurrencyViewController.h"

@interface RVTCurrencyFromViewController : UIViewController < RVTCurrencyViewController >

// TODO - cделать currency приватным для записи из вне
@property (weak, nonatomic) IBOutlet UITextField *textField;
-(instancetype)initWithCurrency:(RVTCurrency *)currency mediator: (RVTExchangeMediator *) mediator;

@end
