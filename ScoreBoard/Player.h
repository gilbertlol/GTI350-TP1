//
//  AppDelegate.h
//  ScoreBoard
//
//  Created by serge nassar on 2016-09-18.
//  Copyright © 2016 serge nassar. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Player:NSObject
{
    NSNumber* number;
    NSString* lastName;
    NSString* name;
    int goal;
    int assist;
}
@property(nonatomic, readwrite) NSNumber* number;
@property(nonatomic, readwrite) NSString* lastName;
@property(nonatomic, readwrite) NSString* name;
@property(nonatomic, readwrite) int goal;
@property(nonatomic, readwrite) int assist;


-(NSString*)toPickerString;
-(int)getScoreValue;

@end