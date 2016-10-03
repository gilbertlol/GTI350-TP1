//
//  Header.h
//  ScoreBoard
//
//  Created by serge nassar on 2016-09-19.
//  Copyright © 2016 serge nassar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface Goal:NSObject
{
    NSNumber* goalNumber;
    Player* scorer;
    Player* assist1;
    Player* assist2;
}
@property(nonatomic, readwrite) NSNumber* goalNumber;
@property(nonatomic, readwrite) Player* scorer;
@property(nonatomic, readwrite) Player* assist1;
@property(nonatomic, readwrite) Player* assist2;

@end