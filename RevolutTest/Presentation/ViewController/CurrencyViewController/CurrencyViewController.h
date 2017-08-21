//
//  CurrencyViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 17/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@protocol CurrencyViewController <NSObject>
-(Currency *)currency;
@end
