//
//  IAPHelper.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/22/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//


#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>
 NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";

@interface IAPHelper () <SKProductsRequestDelegate,SKProductsRequestDelegate, SKPaymentTransactionObserver>
@end

@implementation IAPHelper {
    SKProductsRequest * _productsRequest;
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
   
}
- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
        for (NSString * productIdentifier in _productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                [_purchasedProductIdentifiers addObject:productIdentifier];
           //     NSLog(@"Previously purchased: %@", productIdentifier);
            } else {
             //   NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];   
    }
        return self;
}
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    _completionHandler = [completionHandler copy];
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray * skProducts = response.products;
 /*   for (SKProduct * skProduct in skProducts) {
        NSLog(@"Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
    }*/
    
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}
- (BOOL)productPurchased:(NSString *)productIdentifier {
    return [_purchasedProductIdentifiers containsObject:productIdentifier];
}

- (void)buyProduct:(SKProduct *)product {
    
    NSLog(@"Buying %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
                
            default:
                break;
        }
    };
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"completeTransaction...");
    
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    // add product IDs to the database
    if ([transaction.payment.productIdentifier isEqualToString:@"250coins"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Added 250 Coins!" message:[NSString stringWithFormat:@"Thank you for your purchase! \n you now have %li Coins!",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"coins"]] delegate:self cancelButtonTitle:@"Awesome" otherButtonTitles:nil, nil];
        [alert show];
    }
    else  if ([transaction.payment.productIdentifier isEqualToString:@"tankpack1"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Added 2 New Tanks!" message:[NSString stringWithFormat:@"Thank you for your purchase!"] delegate:self cancelButtonTitle:@"Awesome" otherButtonTitles:nil, nil];
        [alert show];
    }
    else  if ([transaction.payment.productIdentifier isEqualToString:@"removeAds"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No More Ads!" message:[NSString stringWithFormat:@"Thank you for your purchase!  You should never see an ad again!"] delegate:self cancelButtonTitle:@"Awesome" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (void)restoreCompletedTransactions {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"restoreTransaction...");
    
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    if ([transaction.payment.productIdentifier isEqualToString:@"250coins"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Added 250 Coins!" message:[NSString stringWithFormat:@"Thank you for your purchase! \n you now have %li Coins!",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"coins"]] delegate:self cancelButtonTitle:@"Awesome" otherButtonTitles:nil, nil];
        [alert show];
    }
    if ([transaction.payment.productIdentifier isEqualToString:@"tankpack1"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Added 2 New Tanks!" message:[NSString stringWithFormat:@"Thank you for your purchase!"] delegate:self cancelButtonTitle:@"Awesome" otherButtonTitles:nil, nil];
        [alert show];
    }
    if ([transaction.payment.productIdentifier isEqualToString:@"removeAds"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"No More Ads!" message:[NSString stringWithFormat:@"Thank you for your purchase!  You should never see an ad again!"] delegate:self cancelButtonTitle:@"Awesome" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];\
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    
    if ([productIdentifier isEqualToString:@"250coins"]) {
        
        int currentValue = (int)[[NSUserDefaults standardUserDefaults]
                            integerForKey:@"250coins"];
        currentValue += 250;
        [[NSUserDefaults standardUserDefaults] setInteger:currentValue
                                                   forKey:@"250coins"];
        NSInteger coins = [[NSUserDefaults standardUserDefaults] integerForKey:@"coins"];
        coins = coins +250;
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"coins"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    }
    else if ([productIdentifier isEqualToString:@"tankpack1"]) {
        BOOL tank4Unlocked = true;
        BOOL tank5Unlocked = true;
        [[NSUserDefaults standardUserDefaults]setBool:tank4Unlocked forKey:@"tank4"];
        [[NSUserDefaults standardUserDefaults]setBool:tank5Unlocked forKey:@"tank5"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([productIdentifier isEqualToString:@"removeAds"]) {
      
        BOOL removeAds = true;
        [[NSUserDefaults standardUserDefaults]setBool:removeAds forKey:@"removeAds"];
       
    }
    else {
        [_purchasedProductIdentifiers addObject:productIdentifier];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:IAPHelperProductPurchasedNotification
     object:productIdentifier userInfo:nil];
    
}
@end