//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/17.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
                   mode:(NSUInteger)mode;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)setModeFromView:(int)mode;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSMutableArray *result;
@property (nonatomic, readonly) int mode;

@end
