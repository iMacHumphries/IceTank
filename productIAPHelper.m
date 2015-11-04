//
//  productIAPHelper.m
//  ScrappyTank
//
//  Created by Benjamin Humphries on 4/22/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "productIAPHelper.h"

@implementation productIAPHelper

+ (productIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static productIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"250coins",
                                      @"tankpack1",
                                      @"removeAds",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
