//
//  CurrencyToPageViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "CurrencyToPageViewController.h"
#import "CurrencyToViewController.h"

@interface CurrencyToPageViewController ()

@end

@implementation CurrencyToPageViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [NSMutableArray new];
    
    for (Currency *currency in self.mediator.currencies) {
        CurrencyToViewController *controller = [[CurrencyToViewController alloc] initWithCurrency:currency mediator: self.mediator];
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
        self.mediator.currencyTo = self.currentController.currency;
    } else {
        self.currentController = nil;
    }
}

@end
