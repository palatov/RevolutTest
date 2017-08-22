//
//  RVTCurrencyExchangeViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 13/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Контроллер, содержаший оба контроллера с валютами 
 и текстовое поле для ввода количества.
 */
@interface RVTCurrencyExchangeViewController : UIViewController

// Место для верхенего контроллера с валютами
@property (weak, nonatomic) IBOutlet UIView *firstContainerView;
// Место для нижнего контроллера с валютами
@property (weak, nonatomic) IBOutlet UIView *secondContainerView;
// Место для клавиатуры
@property (weak, nonatomic) IBOutlet UIView *keyboardSpaceholder;
// Констрейнт поджимающий контроллеры с валютами снизу
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardSpaceholderDefaultHeight;

@end
