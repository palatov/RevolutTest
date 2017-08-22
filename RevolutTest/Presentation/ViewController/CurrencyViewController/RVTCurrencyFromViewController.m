//
//  RVTCurrencyFromViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrencyFromViewController.h"
#import "RVTNumberFormatter.h"
#import "RVTConstants.h"

@interface RVTCurrencyFromViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyAmmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyRateLabel;

@end

@implementation RVTCurrencyFromViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currencyNameLabel.text = self.currency.currencyId;
    
    [self.mediator addObserver:self
                    forKeyPath:currencyTo
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.mediator addObserver:self
                    forKeyPath:exchangeIsPossible
                       options:NSKeyValueObservingOptionNew
                       context:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    double balance = [self.mediator balanceForCurrencyWithId:self.currency.currencyId];
    self.currencyAmmountLabel.text = [RVTNumberFormatter stringFromDouble:balance];
    [self updateRateLabel];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:currencyTo]) {
        RVTCurrency *currencyTo = change[@"new"];
        NSString *rate = [RVTNumberFormatter stringFromDouble: [currencyTo rateForCurrencyWithId:self.currency.currencyId]];
        self.currencyRateLabel.text = [NSString stringWithFormat:@"%@1 = %@%@",
                                       self.currency.symbol,
                                       currencyTo.symbol,
                                       rate];
    }
    
    if ([keyPath isEqualToString:exchangeIsPossible]) {
        NSNumber *isPossible = change[@"new"];
        self.currencyAmmountLabel.textColor = [isPossible boolValue] ? [UIColor whiteColor] : [UIColor redColor];
    }
    
    if ([keyPath isEqualToString:gbpBalance] && [self.currency.currencyId isEqualToString:GBP]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [RVTNumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:usdBalance] && [self.currency.currencyId isEqualToString:USD]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [RVTNumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:eurBalance] && [self.currency.currencyId isEqualToString:EUR]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [RVTNumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:lastUpdateTimestamp]) {
        [self updateRateLabel];
    }
}

- (void)dealloc {
    [self.mediator removeObserver:self forKeyPath:gbpBalance];
    [self.mediator removeObserver:self forKeyPath:usdBalance];
    [self.mediator removeObserver:self forKeyPath:eurBalance];
    [self.mediator removeObserver:self forKeyPath:lastUpdateTimestamp];
    [self.mediator removeObserver:self forKeyPath:currencyTo];
    [self.mediator removeObserver:self forKeyPath:exchangeIsPossible];
}

#pragma mark - Private

-(void)updateRateLabel {
    RVTCurrency *currencyTo = self.mediator.currencyTo;
    NSString *rate = [RVTNumberFormatter stringFromDouble: [currencyTo rateForCurrencyWithId:self.currency.currencyId]];
    self.currencyRateLabel.text = [NSString stringWithFormat:@"%@1 = %@%@",
                                   self.currency.symbol,
                                   currencyTo.symbol,
                                   rate];
}

@end
