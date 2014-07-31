//
//  CardSetGame.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardSetGame.h"
#import "PlayingCardSet.h"
#import "PlayingCardSetDeck.h"

@interface CardSetGame()

@property (nonatomic, readwrite) int score;
@property (nonatomic, strong) NSMutableArray *cards; //of PlayingCardSet
@property (nonatomic, readwrite) NSMutableArray *result; //of NSMutableAttributedString
@property (nonatomic, readwrite) int mode;

@end

@implementation CardSetGame

- (NSMutableArray *)cards {
    if(!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck{
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
        self.mode = 3;
    }
    return self;
}

- (NSMutableArray *)result {
    if(!_result) {
        _result = [[NSMutableArray alloc] initWithCapacity:1000];
        [_result addObject:[[NSMutableAttributedString alloc] initWithString:@"Play Game!"]];
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
                    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
                    [result appendAttributedString:card.attributedContents];
                    for(Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                        [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
                        [result appendAttributedString:otherCard.attributedContents];
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\nfor %d points",(matchScore*MATCH_BONUS)]]];
                    [self.result addObject:result];
                } else {
                    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithAttributedString:card.attributedContents];
                    for(Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                        [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
                        [result appendAttributedString:otherCard.attributedContents];
                    }
                    self.score -= MISMATCH_PENALTY;
                    [result appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match!\n%d point penalty!",MISMATCH_PENALTY]]];
                    [self.result addObject:result];
                }
            } else {
                NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Flipped up "]];
                [result appendAttributedString:card.attributedContents];
                [self.result addObject:result];
            }
            self.score -= FLIP_COST;
        } else {
            NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Flipped up "]];
            [result appendAttributedString:card.attributedContents];
            [self.result addObject:result];
        }
        card.faceUp = !card.faceUp;
    }
}

@end
