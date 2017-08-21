//
//  CurrencyFromViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 16/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "CurrencyFromViewController.h"
#import "NumberFormatter.h"

@interface CurrencyFromViewController () <UITextFieldDelegate>

@property (strong, nonatomic) ExchangeMediator *mediator;
@property (strong, nonatomic) Currency *currency;

@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyAmmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyRateLabel;

@end

@implementation CurrencyFromViewController

-(instancetype)initWithCurrency:(Currency *)currency mediator: (ExchangeMediator *) mediator {
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
    self.currencyAmmountLabel.text = [NumberFormatter stringFromDouble:balance];
    [self updateRateLabel];
}

-(void)updateRateLabel {
    Currency *currencyTo = self.mediator.currencyTo;
    NSString *rate = [NumberFormatter stringFromDouble: [currencyTo rateForCurrencyWithId:self.currency.currencyId]];
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

-(Currency *)currentCurrency {
    return self.currency;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"currencyTo"]) {
        Currency *currencyTo = change[@"new"];
        NSString *rate = [NumberFormatter stringFromDouble: [currencyTo rateForCurrencyWithId:self.currency.currencyId]];
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

@end
