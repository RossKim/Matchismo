//
//  GameResult.h
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (readonly, nonatomic) int mode;
@property (readonly, nonatomic) int score;

+ (NSArray *)allGameResults; // of GameRsult
- (void)setGame:(NSUInteger)score mode:(NSUInteger)mode;

@end
