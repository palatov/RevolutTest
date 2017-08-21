//
//  CurrencyExchangeViewController.h
//  RevolutTest
//
//  Created by Nikita Timonin on 13/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyExchangeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *firstContainerView;
@property (weak, nonatomic) IBOutlet UIView *secondContainerView;
@property (weak, nonatomic) IBOutlet UIView *keyboardSpaceholder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardSpaceholderDefaultHeight;

@end
