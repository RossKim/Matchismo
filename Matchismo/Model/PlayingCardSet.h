//
//  PlayingCardSet.h
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCardSet : Card

#define MAX_COLOR 3
#define MAX_SHADING 3

@property (strong, nonatomic) NSString* symbol;
@property (nonatomic) NSUInteger number;
@property (nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *shading;

+ (NSArray *)validSymbol;
+ (NSUInteger)maxNumber;
+ (NSArray *)validColor;
+ (NSArray *)validShading;
@end
