//
//  RVTNumberFormatter.h
//  RevolutTest
//
//  Created by Nikita Timonin on 17/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Помщник для форматирования чисел.
 */
@interface RVTNumberFormatter : NSObject

/**
 Переводит число с точкой в строку.

 @param doubleValue Число с точкой
 @return Строка
 */
+ (NSString *)stringFromDouble: (double) doubleValue;

@end
