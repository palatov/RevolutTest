//
//  CurrencyService.h
//  RevolutTest
//
//  Created by Nikita Timonin on 12/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface CurrencyService : NSObject

typedef void(^completionBlock)(NSArray<Currency *> *);
typedef void(^errorHandler)(NSError *error);
- (instancetype)initWithCompletionBlock: (completionBlock) block errorHandler: (errorHandler) handler;
- (void)updateCurrencies; 

@end
