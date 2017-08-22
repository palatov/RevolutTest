//
//  RVTCurrencyToViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrencyToViewController.h"
#import "RVTCurrency.h"
#import "RVTNumberFormatter.h"
#import "RVTConstants.h"

@interface RVTCurrencyToViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchangedAmmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyAmmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyRateLabel;

@end

@implementation RVTCurrencyToViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currencyNameLabel.text = self.currency.currencyId;
  
    [self.mediator addObserver:self
                    forKeyPath:exchangedAmount
                       options:NSKeyValueObservingOptionNew
                       context: nil];
    
    [self.mediator addObserver:self
                    forKeyPath:currencyFrom
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
    
    if ([keyPath isEqualToString:exchangedAmount]) {
        NSNumber *amount = change[@"new"];
        NSString *amounString = [RVTNumberFormatter stringFromDouble:[amount doubleValue]];
        self.exchangedAmmountLabel.text = amounString;
    }
    
    if ([keyPath isEqualToString:currencyFrom]) {
        RVTCurrency *currencyFrom = change[@"new"];
        NSString *rate = [RVTNumberFormatter stringFromDouble: [currencyFrom rateForCurrencyWithId:self.currency.currencyId]];
        self.currencyRateLabel.text = [NSString stringWithFormat:@"%@1 = %@%@",
                                       self.currency.symbol,
                                       currencyFrom.symbol,
                                       rate];
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
    [self.mediator removeObserver:self forKeyPath:currencyFrom];
    [self.mediator removeObserver:self forKeyPath:exchangedAmount];
}

#pragma mark - Private

-(void)updateRateLabel {
    RVTCurrency *currencyFrom = self.mediator.currencyFrom;
    NSString *rate = [RVTNumberFormatter stringFromDouble: [currencyFrom rateForCurrencyWithId:self.currency.currencyId]];
    self.currencyRateLabel.text = [NSString stringWithFormat:@"%@1 = %@%@",
                                   self.currency.symbol,
                                   currencyFrom.symbol,
                                   rate];
}

@end
