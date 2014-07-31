//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/17.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) int score;
@property (nonatomic, strong) NSMutableArray *cards; //of PlayingCard
@property (nonatomic, readwrite) NSMutableArray *result; //of NSString
@property (nonatomic, readwrite) int mode;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if(!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck mode:(NSUInteger)mode{
    self = [super init];
    if(self) {
        for(int i=0;i<cardCount;i++) {
            Card *card = [deck drawRandomCard];
            if(!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        self.mode = mode;
    }
    return self;
}

- (NSMutableArray *)result {
    if(!_result) {
        _result = [[NSMutableArray alloc] initWithCapacity:1000];
        [_result addObject:@"Play Game!"];
    }
    
    return _result;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)setModeFromView:(int)mode {
    self.mode = mode;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4


- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if(!card.isUnplayable) {
        if(!card.faceUp) {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for(Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                }
            }
            if(otherCards.count == self.mode-1) {
                int matchScore = [card match:otherCards];
                if(matchScore) {
                    NSString *otherCardContents = @"";
                    for(Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                        otherCardContents = [NSString stringWithFormat:@"%@ & %@",otherCardContents,otherCard.contents];
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    [self.result addObject:[NSString stringWithFormat:@"Matched %@%@\nfor %d points",
                                   card.contents, otherCardContents, (matchScore * MATCH_BONUS)]];

                } else {
                    NSString *otherCardContents = @"";
                    for(Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                        otherCardContents = [NSString stringWithFormat:@"%@ & %@",otherCardContents,otherCard.contents];
                    }
                    self.score -= MISMATCH_PENALTY;
                    [self.result addObject:[NSString stringWithFormat:@"%@%@ don't match!\n%d point penalty!",
                                   card.contents, otherCardContents, MISMATCH_PENALTY]];
                }
            } else {
                [self.result addObject:[NSString stringWithFormat:@"Flipped up %@",card.contents]];
            }
            self.score -= FLIP_COST;
        } else {
            [self.result addObject:[NSString stringWithFormat:@"Flipped up %@",card.contents]];
        }
        card.faceUp = !card.faceUp;
    }
}

@end
