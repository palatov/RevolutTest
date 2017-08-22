//
//  RVTCurrency.h
//  RevolutTest
//
//  Created by Nikita Timonin on 15/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVTCurrency : NSObject

@property (strong, nonatomic ) NSString *currencyId;
@property (nonatomic) double toEur;
@property (nonatomic) double toUSD;
@property (nonatomic) double toGBP;
@property (nonatomic) double lastUpdateTimestamp;
@property (strong, nonatomic) NSString *symbol;

-(instancetype)initWith: (NSString *)currencyId
              toEURRate: (double) toEur
              toUSDRate: (double) toUSD
              toGBPRate: (double) toGBP
    lastUpdateTimestamp: (double) timestamp;

-(void)updateWith: (RVTCurrency *)newModel;
-(double)rateForCurrencyWithId: (NSString *)currencyId;

@end
