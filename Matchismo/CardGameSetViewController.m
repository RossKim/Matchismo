//
//  CardGameSetViewController.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardGameSetViewController.h"
#import "PlayingCardSetDeck.h"
#import "CardSetGame.h"
#import "GameResult.h"

@interface CardGameSetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardSetGame *game;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation CardGameSetViewController

- (CardSetGame *)game {
    if(!_game) {
        _game = [[CardSetGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[[PlayingCardSetDeck alloc] init]];
    }
    return _game;
}

- (GameResult *)gameResult {
    if(!_gameResult) {
        _gameResult = [[GameResult alloc] init];
    }
    return _gameResult;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:card.attributedContents forState:UIControlStateNormal];
        cardButton.enabled = !card.isUnplayable;
        if(card.isUnplayable) {
            cardButton.alpha = 0;
        }
        if(card.isFaceUp) {
            cardButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        } else {
            cardButton.backgroundColor = [UIColor whiteColor];
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    [self.resultLabel setAttributedText:[self.game.result lastObject]];
}

- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    [self.gameResult setGame:self.game.score mode:2];
}

@end
