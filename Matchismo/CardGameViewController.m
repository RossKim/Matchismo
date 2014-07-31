//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/15.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                                       mode:2];
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
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.jpeg"];
    UIImage *backImage = [[UIImage alloc] init];
    for(UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        [cardButton setImage:backImage forState:UIControlStateSelected];
        [cardButton setImage:backImage forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(0.8, 0, 0.8, 0)];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    [self setPastUI:NO];
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    self.historySlider.maximumValue++;
    [self.gameResult setGame:self.game.score mode:1];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealGame:(UIButton *)sender {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    self.historySlider.maximumValue = 0;
    [self updateUI];
}

- (IBAction)changeHistorySliderValue:(UISlider *)sender {
    if(sender.value == [sender maximumValue]) {
        [self setPastUI:NO];
    } else {
        [self setPastUI:YES];
    }
}

- (void)setPastUI:(BOOL)isPast {
    self.resultLabel.alpha = isPast ? 0.3 : 1.0;
    if(!isPast) {
        self.historySlider.value = self.historySlider.maximumValue;
    }
    self.resultLabel.text = [self.game.result objectAtIndex:self.historySlider.value];
}

@end
