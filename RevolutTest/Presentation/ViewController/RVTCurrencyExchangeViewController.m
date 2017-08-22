//
//  RVTCurrencyExchangeViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 13/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrencyExchangeViewController.h"
#import "RVTCurrencyFromPageViewController.h"
#import "RVTCurrencyToPageViewController.h"
#import "RVTCurrency.h"
#import "RVTCurrencyService.h"
#import "RVTCurrencyFromViewController.h"
#import "RVTConstants.h"

@interface RVTCurrencyExchangeViewController ()

@property (strong, nonatomic) RVTCurrencyService *currencyService;
@property (strong, nonatomic) RVTCurrencyFromPageViewController *currencyFromPageViewController;
@property (strong, nonatomic) RVTCurrencyToPageViewController *currencyToPageViewController;
@property (strong, nonatomic) RVTExchangeMediator *mediator;

@end

/// Держать модели здесь

@implementation RVTCurrencyExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currencyService = [[RVTCurrencyService alloc] initWithCompletionBlock:^(NSArray<RVTCurrency *> *currencies) {
        [self setupExchangeMediator:currencies];
        if (self.currencyFromPageViewController == nil && self.currencyToPageViewController == nil) {
            [self setupPageViewControllers];
            [self setupTextField];
        }
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

-(void)setupExchangeMediator: (NSArray<RVTCurrency *> *) currencies {
    if (!self.mediator) {
        self.mediator = [[RVTExchangeMediator alloc] initWithCurrencies:currencies];
        [self.mediator addObserver:self forKeyPath:exchangeIsPossible options:NSKeyValueObservingOptionNew context:nil];
    } else {
        [self.mediator updateCurrencies:currencies];
    }
}

-(void)setupPageViewControllers {
    self.currencyFromPageViewController = [[RVTCurrencyFromPageViewController alloc] initWithMediator: self.mediator];
    
    [self addPageViewController:self.currencyFromPageViewController
                toContainerView:self.firstContainerView];
    
    self.currencyToPageViewController = [[RVTCurrencyToPageViewController alloc] initWithMediator: self.mediator];
    
    [self addPageViewController:self.currencyToPageViewController
                toContainerView:self.secondContainerView];
}

-(void)setupTextField {
    UITextField *textField = [UITextField new];
    textField.textColor = [UIColor whiteColor];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.backgroundColor = [UIColor blackColor];
    textField.textAlignment = NSTextAlignmentRight;
    textField.font = [UIFont systemFontOfSize:25.0];
    textField.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.firstContainerView addSubview:textField];
    NSArray * arr = @[[textField.trailingAnchor constraintEqualToAnchor:self.firstContainerView.trailingAnchor constant: -16.0],
                      [textField.topAnchor constraintEqualToAnchor:self.firstContainerView.topAnchor constant: 16.0],
                      [textField.widthAnchor constraintEqualToConstant:140.0]
                      ];
    [NSLayoutConstraint activateConstraints:arr];
    [textField becomeFirstResponder];
    
    [textField addTarget:self
                  action:@selector(didEditTextField:)
        forControlEvents:UIControlEventEditingChanged];
}

-(void)didEditTextField: (UITextField *)textField {
    [self.mediator exchangeCurrencyWithAmmount:[textField.text doubleValue]];
}

- (void)addPageViewController: (UIPageViewController *)pageViewController
              toContainerView: (UIView *) containerView {
    [self addChildViewController:pageViewController];
    [pageViewController didMoveToParentViewController:self];
    [containerView addSubview:pageViewController.view];
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false;
    NSArray *arr = @[ [pageViewController.view.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
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
    
    if ([keyPath isEqualToString:exchangeIsPossible]) {
        NSNumber *isPossible = change[@"new"];
        [self.navigationItem.rightBarButtonItem setEnabled: [isPossible boolValue]];
    }
}

-(void)performExchange:(id)sender {
    [self.mediator saveExchangeResult];
}

@end
