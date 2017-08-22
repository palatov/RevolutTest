//
//  RVTCurrencyService.m
//  RevolutTest
//
//  Created by Nikita Timonin on 12/08/2017.
//  Copyright © 2017 Timonin. All rights reserved.
//

#import "RVTCurrencyService.h"
#import "RVTAppSettingsService.h"


@interface RVTCurrencyService () <NSXMLParserDelegate>

@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) double lastUpdateTimestamp;
@property (nonatomic) completionBlock completionBlock;
@property (nonatomic) errorHandler errorHandler;

@property (nonatomic) double eurToUsdRate;
@property (nonatomic) double eurToGbpRate;

@end

@implementation RVTCurrencyService

static NSString *rate = @"rate";
static NSString *ecbRates = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

- (instancetype)initWithCompletionBlock: (completionBlock) block errorHandler: (errorHandler) handler {
    self = [super init];
    self.completionBlock = block;
    self.errorHandler = handler;
    return self;
}

- (void)updateCurrencies {
    NSURL *url = [NSURL URLWithString:ecbRates];
    [self downloadDataFromURL:url withCompletionHandler:^(NSData *data) {
        if (data != nil) {
            
            //FIXME: - здесь может быть retain cycle
            self.lastUpdateTimestamp = [[NSDate new] timeIntervalSince1970];
            
            self.xmlParser = [[NSXMLParser alloc] initWithData:data];
            self.xmlParser.delegate = self;
            
            [self.xmlParser parse];
        }
    }];
}

- (void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void (^)(NSData *))completionHandler{
  
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.errorHandler(error);
            }];
        }
        else{
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            if (HTTPStatusCode != 200) {
                NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completionHandler(data);
            }];
        }
    }];
    
    [task resume];
}

// MARK: - NSXMLParserDelegate

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    NSString *currency = attributeDict[@"currency"];
    
    if ([elementName isEqualToString:@"Cube"]) {
       
        if ([currency  isEqual: @"USD"]) {
            self.eurToUsdRate = [attributeDict[rate] doubleValue];
        }
        
        if ([currency  isEqual: @"GBP"]) {
            self.eurToGbpRate = [attributeDict[rate] doubleValue];
        }
    }
}


-(void)parserDidEndDocument:(NSXMLParser *)parser {
    [self scheduleNextCurrencyUpdate];
    
    if (self.eurToUsdRate != 0 && self.eurToGbpRate != 0) {
        
        double lastUpdateTimestamp = [[NSDate date] timeIntervalSince1970];
        double gbpToUsdRate = self.eurToUsdRate / self.eurToGbpRate;
        
        RVTCurrency *usd = [[RVTCurrency alloc] initWith:@"USD"
                                               toEURRate:1/self.eurToUsdRate
                                               toUSDRate:1.0
                                               toGBPRate:1/gbpToUsdRate
                                     lastUpdateTimestamp:lastUpdateTimestamp];
        
        RVTCurrency *gbp = [[RVTCurrency alloc] initWith:@"GBP"
                                               toEURRate:1/self.eurToGbpRate
                                               toUSDRate:gbpToUsdRate
                                               toGBPRate:1.0
                                     lastUpdateTimestamp:lastUpdateTimestamp];
        
        RVTCurrency *eur = [[RVTCurrency alloc] initWith:@"EUR"
                                               toEURRate:1.0
                                               toUSDRate:self.eurToUsdRate
                                               toGBPRate:self.eurToGbpRate
                                     lastUpdateTimestamp:lastUpdateTimestamp];
        
        NSArray *arr = @[usd, gbp, eur];
        
        self.eurToUsdRate = 0;
        self.eurToGbpRate = 0;
        
        self.completionBlock(arr);
    }
}

-(void)scheduleNextCurrencyUpdate {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateCurrencies];
    });
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    self.errorHandler(parseError);
}

@end
