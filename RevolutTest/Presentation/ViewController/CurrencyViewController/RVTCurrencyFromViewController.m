//
//  RVTCurrencyFromViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrencyFromViewController.h"
#import "RVTNumberFormatter.h"

@interface RVTCurrencyFromViewController () <UITextFieldDelegate>

@property (strong, nonatomic) RVTExchangeMediator *mediator;
@property (strong, nonatomic) RVTCurrency *currency;

@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyAmmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyRateLabel;

@end

@implementation RVTCurrencyFromViewController

-(instancetype)initWithCurrency:(RVTCurrency *)currency mediator: (RVTExchangeMediator *) mediator {
    self = [super initWithNibName:@"CurrencyFromViewController" bundle: nil];
    _currency = currency;
    _mediator = mediator;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currencyNameLabel.text = self.currency.currencyId;
    self.textField.delegate = self;
    
    [self.textField addTarget:self
                       action:@selector(didEditTextField:)
             forControlEvents:UIControlEventEditingChanged];
    
    [self.mediator addObserver:self
                    forKeyPath:@"currencyTo"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.mediator addObserver:self
                    forKeyPath:@"exchangeIsPossible"
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
    self.currencyAmmountLabel.text = [RVTNumberFormatter stringFromDouble:balance];
    [self updateRateLabel];
}

-(void)updateRateLabel {
    RVTCurrency *currencyTo = self.mediator.currencyTo;
    NSString *rate = [RVTNumberFormatter stringFromDouble: [currencyTo rateForCurrencyWithId:self.currency.currencyId]];
    self.currencyRateLabel.text = [NSString stringWithFormat:@"%@1 = %@%@",
                                   self.currency.symbol,
                                   currencyTo.symbol,
                                   rate];
}

-(void)didEditTextField: (UITextField *)textField {
    [self.mediator exchangeCurrencyWithAmmount:[textField.text doubleValue]];
}

// MARK: - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}

// MARK: - CurrencyViewController

-(RVTCurrency *)currentCurrency {
    return self.currency;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"currencyTo"]) {
        RVTCurrency *currencyTo = change[@"new"];
        NSString *rate = [RVTNumberFormatter stringFromDouble: [currencyTo rateForCurrencyWithId:self.currency.currencyId]];
        self.currencyRateLabel.text = [NSString stringWithFormat:@"%@1 = %@%@",
                                       self.currency.symbol,
                                       currencyTo.symbol,
                                       rate];
    }
    
    if ([keyPath isEqualToString:@"exchangeIsPossible"]) {
        NSNumber *isPossible = change[@"new"];
        self.currencyAmmountLabel.textColor = [isPossible boolValue] ? [UIColor whiteColor] : [UIColor redColor];
    }
    
    if ([keyPath isEqualToString:@"gbpBalance"] && [self.currency.currencyId isEqualToString:@"GBP"]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [RVTNumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:@"usdBalance"] && [self.currency.currencyId isEqualToString:@"USD"]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [RVTNumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:@"eurBalance"] && [self.currency.currencyId isEqualToString:@"EUR"]) {
        NSNumber *newAmount = change[@"new"];
        self.currencyAmmountLabel.text = [RVTNumberFormatter stringFromDouble: [newAmount doubleValue]];
    }
    
    if ([keyPath isEqualToString:@"lastUpdateTimestamp"]) {
        [self updateRateLabel];
    }
}

@end
