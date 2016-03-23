//
//  VNAUserNotificationController.m
//  Vienna
//
//  Created by Joshua Pore on 23/03/2016.
//  Copyright © 2016 uk.co.opencommunity. All rights reserved.
//

#import "VNAUserNotificationController.h"

@implementation VNAUserNotificationController

+ (void)notificationWithTitle:(NSString *)title description:(NSString *)description {
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = title;
    notification.informativeText = description;
    notification.deliveryDate = [NSDate date];
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:notification];
}

@end
