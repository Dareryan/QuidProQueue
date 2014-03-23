//
//  Session+Methods.m
//  QuidProQueue
//
//  Created by Dare Ryan on 3/22/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "Session+Methods.h"

@implementation Session (Methods)

-(NSString *)returnFormattedEndTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    
    return [dateFormatter stringFromDate:self.endTime];
}

-(NSString *)returnFormattedStartTime
{
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
        
    return [dateFormatter stringFromDate:self.startTime];
}
@end
