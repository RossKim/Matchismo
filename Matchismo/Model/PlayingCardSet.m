//
//  PlayingCardSet.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "PlayingCardSet.h"

@implementation PlayingCardSet

@synthesize symbol = _symbol;
@synthesize color = _color;
@synthesize shading = _shading;

- (int)match:(NSArray *)otherCards {
    int score = 0;
    BOOL isColor = NO;
    BOOL isSymbol = NO;
    BOOL isShading = NO;
    BOOL isNumber = NO;
    if(otherCards.count == 2) {
        id firstCard = self;
        id secondCard = [otherCards objectAtIndex:0];
        id thirdCard = [otherCards objectAtIndex:1];
        if([firstCard isKindOfClass:[PlayingCardSet class]] &&
           [secondCard isKindOfClass:[PlayingCardSet class]] &&
           [thirdCard isKindOfClass:[PlayingCardSet class]]) {
            PlayingCardSet *firstSet = (PlayingCardSet *)firstCard;
            PlayingCardSet *secondSet = (PlayingCardSet *)secondCard;
            PlayingCardSet *thirdSet = (PlayingCardSet *)thirdCard;
            if(([firstSet.symbol isEqualToString:secondSet.symbol] && [firstSet.symbol isEqualToString:thirdSet.symbol])
               || (![firstSet.symbol isEqualToString:secondSet.symbol] &&
                   ![firstSet.symbol isEqualToString:thirdSet.symbol] &&
                   ![secondSet.symbol isEqualToString:thirdSet.symbol])) {
                isSymbol = YES;
            }
            if ((firstSet.number == secondSet.number && firstSet.number == thirdSet.number) ||
                (firstSet.number != secondSet.number && firstSet.number != thirdSet.number &&
                       secondSet.number != thirdSet.number)) {
                isNumber = YES;
            }
            if(([firstSet.color isEqual:secondSet.color] && [firstSet.color isEqual:thirdSet.color]) ||
                      (![firstSet.color isEqual:secondSet.color] && ![firstSet.color isEqual:thirdSet.color] &&
                       ![secondSet.color isEqual:thirdSet.color])) {
                isColor = YES;
            }
            if(([firstSet.shading isEqualToString:secondSet.shading] &&
                       [firstSet.shading isEqualToString:thirdSet.shading]) ||
                      (![firstSet.shading isEqualToString:secondSet.shading] &&
                       ![firstSet.shading isEqualToString:thirdSet.shading] &&
                       ![secondSet.shading isEqualToString:thirdSet.shading])) {
                isShading = YES;
            }
        }
        if(isColor && isNumber && isColor && isShading) {
            score = 5;
        }
    }
    return score;
}

+ (NSArray *)validSymbol {
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)numberStrings {
    return @[@"?",@"1",@"2",@"3"];
}

+ (NSArray *)validColor {
    return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

+ (NSUInteger)maxNumber {
    return [self numberStrings].count-1;
}

+ (NSArray *)validShading {
    return @[@"solid", @"stripe", @"open"];
}

- (void)setShading:(NSString *)shading {
    if([[PlayingCardSet validShading] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading {
    return _shading ? _shading : @"?";
}

- (void)setColor:(UIColor *)color {
    if([[PlayingCardSet validColor] containsObject:color]) {
        _color = color;
    }
}

- (UIColor *)color {
    return _color ? _color : [UIColor whiteColor];
}

- (void)setSymbol:(NSString *)symbol {
    if([[PlayingCardSet validSymbol] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

- (void)setNumber:(NSUInteger)number {
    if(number <= [PlayingCardSet maxNumber]) {
        _number = number;
    }
}

- (NSString *)contents {
    NSString *contents = @"";
    for(int i=1;i<=self.number;i++) {
        contents = [NSString stringWithFormat:@"%@%@",contents,self.symbol];
    }
    return contents;
}

- (NSMutableAttributedString *)attributedContents {
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:self.contents];
    NSArray *shadings = [PlayingCardSet validShading];
    NSRange r = [[contents string] rangeOfString:self.contents];
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
    [attributes setObject:self.color forKey:NSForegroundColorAttributeName];
    if([self.shading isEqualToString:shadings[0]]) {
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
    } else if([self.shading isEqualToString:shadings[1]]) {
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        [attributes setObject:self.color forKey:NSStrokeColorAttributeName];
        [attributes setObject:[attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
                      forKey:NSForegroundColorAttributeName];
    } else if([self.shading isEqualToString:shadings[2]]) {
        [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    }
    [contents addAttributes:attributes range:r];
    return contents;
}
@end
