//
//  Customer+Methods.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/22/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "Customer+Methods.h"
#import "Location.h"
#import "Session.h"
#import "DataStore.h"


@implementation Customer (Methods)
-(NSString *)calculateWaitTimeForCustomer
{
    if (!self.session.startTime){
        NSDate *currentTime= [NSDate date];
        NSTimeInterval timeInterval = [currentTime timeIntervalSinceDate:self.arrivalTime];
        NSInteger minutesElapsed = (round(timeInterval)/60);
        
        if (minutesElapsed == 1){
            return [NSString stringWithFormat:@"Wait time: %ld minute", (long)minutesElapsed];
        }
        else{
            return [NSString stringWithFormat:@"Wait time: %ld minutes", (long)minutesElapsed];
        }
    }
    else{
        NSDate *sessionStartTime = self.session.startTime;
        NSTimeInterval timeInterval = [sessionStartTime timeIntervalSinceDate:self.arrivalTime];
        
        NSInteger minutesElapsed = (round(timeInterval)/60);
        
        if (minutesElapsed == 1){
            return [NSString stringWithFormat:@"Wait time: %ld minute", (long)minutesElapsed];
        }
        else{
            return [NSString stringWithFormat:@"Wait time: %ld minutes", (long)minutesElapsed];
        }
    }
}



@end
