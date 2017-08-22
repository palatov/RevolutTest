//
//  RVTCurrencyFromPageViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrencyFromPageViewController.h"
#import "RVTCurrencyFromViewController.h"

@interface RVTCurrencyFromPageViewController ()

@end

@implementation RVTCurrencyFromPageViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [NSMutableArray new];
    
    for (RVTCurrency *currency in self.mediator.currencies) {
        RVTCurrencyFromViewController *controller = [[RVTCurrencyFromViewController alloc] initWithCurrency:currency mediator: self.mediator];
        [arr addObject:controller];
    }
    
    self.controllers = [NSArray arrayWithArray:arr];
    
    [self setViewControllers:@[self.controllers[0]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    
    if (completed) {
        self.mediator.currencyFrom = self.currentController.currency;
//        RVTCurrencyFromViewController *previousController = (RVTCurrencyFromViewController *)previousViewControllers.firstObject;
//        RVTCurrencyFromViewController *currentController = (RVTCurrencyFromViewController *)self.currentController;
        // currentController.textField.text = previousController.textField.text;
        // previousController.textField.text = nil;
        // [currentController.textField performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
    } else {
        self.currentController = nil;
    }
}

@end
