//
//  PlayingCardSetDeck.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "PlayingCardSetDeck.h"
#import "PlayingCardSet.h"

@implementation PlayingCardSetDeck

- (id)init {
    self = [super init];
    if(self) {
        for (NSString *symbol in [PlayingCardSet validSymbol]) {
            for(NSUInteger number = 1; number <= [PlayingCardSet maxNumber]; number++) {
                for(UIColor *color in [PlayingCardSet validColor]) {
                    for(NSString *shading in [PlayingCardSet validShading]) {
                        PlayingCardSet *set = [[PlayingCardSet alloc] init];
                        set.symbol = symbol;
                        set.number = number;
                        set.color = color;
                        set.shading = shading;
                        [self addCard:set atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
