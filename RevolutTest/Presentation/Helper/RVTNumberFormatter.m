//
//  RVTNumberFormatter.m
//  RevolutTest
//
//  Created by Nikita Timonin on 17/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTNumberFormatter.h"

@implementation RVTNumberFormatter

+ (NSString *)stringFromDouble: (double) doubleValue {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter  setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter  setMaximumFractionDigits:2];
    return [formatter stringFromNumber:[NSNumber numberWithDouble:doubleValue]];
}

@end
