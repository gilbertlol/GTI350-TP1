//
//  Player.m
//  ScoreBoard
//
//  Created by serge nassar on 2016-09-18.
//  Copyright © 2016 serge nassar. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize number;
@synthesize lastName;
@synthesize name;
@synthesize goal;
@synthesize assist;

-(id)init
{
    self = [super init];
    goal = 0;
    assist = 0;
    return self;
}

-(NSString*)description {
    return [NSString stringWithFormat: @"%@ - %@, Goals: %d Assists: %d", number, name, goal, assist];
}

-(NSString*)toPickerString {
    return [NSString stringWithFormat: @"%@", number];
}

-(int)getScoreValue {
    return (goal * 1) + (assist * 1);
}
@end
