//
//  Card.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/15.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    for(Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
