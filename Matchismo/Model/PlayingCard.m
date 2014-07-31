//
//  PlayingCard.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/15.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards {
    int score = 0;
    int mode = otherCards.count;
    if(mode == 1 || mode == 2) {
        for(id otherCard in otherCards) {
            if([otherCard isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
                int matchScore = 0;
                if([otherPlayingCard.suit isEqualToString:self.suit]) {
                    matchScore = 1 * mode;
                } else if(otherPlayingCard.rank == self.rank) {
                    matchScore = 4 * mode;
                }
                if(matchScore) {
                    score += matchScore;
                } else {
                    return 0;
                }
            }
        }
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (void)setSuit:(NSString *)suit {
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank {
    if(rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
