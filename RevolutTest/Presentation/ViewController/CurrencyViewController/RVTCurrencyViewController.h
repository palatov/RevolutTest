//
//  RVTCurrencyViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 17/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVTCurrency.h"

@protocol RVTCurrencyViewController <NSObject>
-(RVTCurrency *)currency;
@end
