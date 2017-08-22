//
//  RVTCurrencyPageViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 13/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrencyPageViewController.h"
#import "RVTCurrency.h"

@interface RVTCurrencyPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@end

@implementation RVTCurrencyPageViewController

- (instancetype _Nonnull )initWithMediator: (RVTExchangeMediator * _Nonnull ) mediator {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                  options:nil];
    _mediator = mediator;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad]; 
    self.dataSource = self;
    self.delegate = self;
}

// MARK: - UIPageViewControllerDataSource

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self.controllers indexOfObject:viewController];
    NSUInteger maxIndex = self.controllers.count - 1;
    
    if (index == 0) {
        return self.controllers[maxIndex];
    } else {
        return self.controllers[index - 1];
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self.controllers indexOfObject:viewController];
    NSUInteger maxIndex = self.controllers.count - 1;
    
    if (index == maxIndex) {
        return self.controllers[0];
    } else {
        return self.controllers[index + 1];
    }
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.controllers.count; 
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

// MARK: - UIPageViewConrtollerDelegate

-(void)pageViewController:(UIPageViewController *)pageViewController
willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.currentController = (id<RVTCurrencyViewController>)pendingViewControllers.firstObject;
}

@end
