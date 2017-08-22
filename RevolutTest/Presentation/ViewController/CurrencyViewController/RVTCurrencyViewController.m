//
//  RVTCurrencyViewController.m
//  RevolutTest
//
//  Created by Nikita Timonin on 22/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrencyViewController.h"
#import "RVTConstants.h"

@interface RVTCurrencyViewController ()

@property (strong, nonatomic) RVTExchangeMediator *mediator;

@end

@implementation RVTCurrencyViewController

#pragma mark - Public

-(instancetype)initWithCurrency:(RVTCurrency *)currency mediator: (RVTExchangeMediator *) mediator {
    NSString *nibName = NSStringFromClass([self class]);
    self = [super initWithNibName:nibName bundle:nil];
    _currency = currency;
    _mediator = mediator;
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mediator addObserver:self
                    forKeyPath:gbpBalance
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.mediator addObserver:self
                    forKeyPath:usdBalance
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.mediator addObserver:self
                    forKeyPath:eurBalance
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.currency addObserver:self
                    forKeyPath:lastUpdateTimestamp
                       options:NSKeyValueObservingOptionNew
                       context:nil];
}

@end
