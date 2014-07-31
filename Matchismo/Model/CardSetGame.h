//
//  CardSetGame.h
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardSetGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)setModeFromView:(int)mode;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSMutableArray *result;

@end