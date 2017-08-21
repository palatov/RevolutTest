//
//  CurrencyExchangeViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 13/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "CurrencyExchangeViewController.h"
#import "CurrencyFromPageViewController.h"
#import "CurrencyToPageViewController.h"
#import "Currency.h"
#import "CurrencyService.h"
#import "CurrencyFromViewController.h"

@interface CurrencyExchangeViewController () 

@property (strong, nonatomic) CurrencyService *currencyService;
@property (strong, nonatomic) CurrencyFromPageViewController *currencyFromPageViewController;
@property (strong, nonatomic) CurrencyToPageViewController *currencyToPageViewController;
@property (strong, nonatomic) ExchangeMediator *mediator;

@end

/// Держать модели здесь

@implementation CurrencyExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currencyService = [[CurrencyService alloc] initWithCompletionBlock:^(NSArray<Currency *> *currencies) {
        [self setupExchangeMediator:currencies];
        [self.navigationItem.rightBarButtonItem setEnabled: TRUE];
    } errorHandler:^(NSError *error) {
        [self.navigationItem.rightBarButtonItem setEnabled: FALSE];
        [self presentError:error];
    }];
    
    [self.currencyService updateCurrencies];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                initWithTitle:@"Exchange"
                                                style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(performExchange:)]];
     [self.navigationItem.rightBarButtonItem setEnabled: FALSE];
}

-(void)presentError: (NSError *) error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                   message: [NSString stringWithFormat:@"%@", [error localizedDescription]]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ок"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                          [self.currencyService updateCurrencies];
                                                     }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:TRUE completion:nil];
}

-(void)setupExchangeMediator: (NSArray<Currency *> *) currencies {
    // TODO: - позже можно заменить его на протокол
    if (!self.mediator) {
        self.mediator = [[ExchangeMediator alloc] initWithCurrencies:currencies];
        [self.mediator addObserver:self forKeyPath:@"exchangeIsPossible" options:NSKeyValueObservingOptionNew context:nil];
    } else {
        [self.mediator updateCurrencies:currencies];
    }
    
    if (self.currencyFromPageViewController == nil && self.currencyToPageViewController == nil) {
        [self setupPageViewControllers];
    }
}

-(void)setupPageViewControllers {
    self.currencyFromPageViewController = [[CurrencyFromPageViewController alloc] initWithMediator: self.mediator];
    
    [self addPageViewController:self.currencyFromPageViewController
                toContainerView:self.firstContainerView];
    
    self.currencyToPageViewController = [[CurrencyToPageViewController alloc] initWithMediator: self.mediator];
    
    [self addPageViewController:self.currencyToPageViewController
                toContainerView:self.secondContainerView];
    
    CurrencyFromViewController * initialController = (CurrencyFromViewController *)self.currencyFromPageViewController.viewControllers.firstObject;
    [initialController.textField becomeFirstResponder];
}

- (void)addPageViewController: (UIPageViewController *)pageViewController
              toContainerView: (UIView *) containerView {
    [self addChildViewController:pageViewController];
    [pageViewController didMoveToParentViewController:self];
    [containerView addSubview:pageViewController.view];
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false;
    NSArray *arr = @[
    [pageViewController.view.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
    [pageViewController.view.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
    [pageViewController.view.topAnchor constraintEqualToAnchor:containerView.topAnchor],
    [pageViewController.view.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor]];
    [NSLayoutConstraint activateConstraints:arr];
}

- (void)keyboardDidShow: (NSNotification *) notification{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    self.keyboardSpaceholderDefaultHeight.active = NO; 
    [self.keyboardSpaceholder.heightAnchor constraintEqualToConstant:keyboardFrameBeginRect.size.height].active = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"exchangeIsPossible"]) {
        NSNumber *isPossible = change[@"new"];
        [self.navigationItem.rightBarButtonItem setEnabled: [isPossible boolValue]];
    }
}

-(void)performExchange:(id)sender {
    [self.mediator saveExchangeResult];
}

@end
