//
//  CurrencyToViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "CurrencyToViewController.h"
#import "Currency.h"
#import "NumberFormatter.h"

@interface CurrencyToViewController ()

@property (strong, nonatomic) ExchangeMediator *mediator;
@property (strong, nonatomic) Currency *currency;

@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchangedAmmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyAmmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyRateLabel;

@end

@implementation CurrencyToViewController

-(instancetype)initWithCurrency:(Currency *)currency mediator: (ExchangeMediator *) mediator {
    self = [super initWithNibName:@"CurrencyToViewController" bundle: nil];
    _currency = currency;
    _mediator = mediator;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currencyNameLabel.text = self.currency.currencyId;
  
    [self.mediator addObserver:self
                    forKeyPath:@"exchangedAmount"
                       options:NSKeyValueObservingOptionNew
                       context: nil];
    
    [self.mediator addObserver:self
                    forKeyPath:@"currencyFrom"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.mediator addObserver:self
                    forKeyPath:@"gbpBalance"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.mediator addObserver:self
                    forKeyPath:@"usdBalance"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.mediator addObserver:self
                    forKeyPath:@"eurBalance"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.currency addObserver:self
                    forKeyPath:@"lastUpdateTimestamp"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    double balance = [self.mediator balanceForCurrencyWithId:self.currency.currencyId];
    self.currencyAmmountLabel.text = [NumberFormatter stringFromDouble:balance];
    [self updateRateLabel];
}

-(void)updateRateLabel {
    Currency *currencyFrom = self.mediator.currencyFrom;
    NSString *rate = [NumberFormatter stringFromDouble: [currencyFrom rateForCurrencyWithId:self.currency.currencyId]];
    self.currencyRateLabel.text = [NSString stringWithFormat:@"%@1 = %@%@",
                                   self.currency.symbol,
                                   currencyFrom.symbol,
                                   rate];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"exchangedAmount"]) {
        NSNumber *amount = change[@"new"];
        NSString *amounString = [NumberFormatter stringFromDouble:[amount doubleValue]];
        self.exchangedAmmountLabel.text = amounString;
    }
    
    if ([keyPath isEqualToString:@"currencyFrom"]) {
        Currency *currencyFrom = change[@"new"];
        NSString *rate = [NumberFormatter stringFromDouble: [currencyFrom rateForCurrencyWithId:self.currency.currencyId]];
        self.currencyRateLabel.text = [NSString stringWithFormat:@"%@1 = %@%@",
                                       self.currency.symbol,
                                       currencyFrom.symbol,
                                       rate];
    }
    
    if ([keyPath isEqualToString:@"gbpBalance"] && [self.currency.currencyId isEqualToString:@"GBP"]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [NumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:@"usdBalance"] && [self.currency.currencyId isEqualToString:@"USD"]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [NumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:@"eurBalance"] && [self.currency.currencyId isEqualToString:@"EUR"]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [NumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:@"lastUpdateTimestamp"]) {
        [self updateRateLabel];
    }
}


// MARK: - CurrencyViewController

-(Currency *)currentCurrency {
    return self.currency;
}

@end
