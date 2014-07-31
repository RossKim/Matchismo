//
//  CardGameScoreViewController.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "CardGameScoreViewController.h"
#import "GameResult.h"

@interface CardGameScoreViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation CardGameScoreViewController

- (void)updateUI {
    [self updateUIWithResults:[GameResult allGameResults]];
}

- (void)updateUIWithResults:(NSArray *)resultArray {
    NSString *displayText = @"";
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    for(GameResult *result in resultArray) {
        if(result.mode == 1) {
            displayText = [displayText stringByAppendingFormat:@"Mode:Card "];
        } else if(result.mode == 2) {
            displayText = [displayText stringByAppendingFormat:@"Mode:Set "];
        }
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n",result.score, [format stringFromDate:result.end], round(result.duration)];
    }
    self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)setup {
    // initialization that can't wait until viewDidLoad
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

- (IBAction)sortByDate:(UIButton *)sender {
    NSArray *resultArray = [[GameResult allGameResults] sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [((GameResult *)obj1).start compare:((GameResult *)obj2).start];
    }];
    
    [self updateUIWithResults:resultArray];
}

- (IBAction)sortByScore:(UIButton *)sender {
    NSArray *resultArray = [[GameResult allGameResults] sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [@(((GameResult *)obj2).score) compare:@(((GameResult *)obj1).score)];
    }];
    
    [self updateUIWithResults:resultArray];
}

- (IBAction)sortByDuration:(UIButton *)sender {
    NSArray *resultArray = [[GameResult allGameResults] sortedArrayUsingComparator:^(id obj1, id obj2) {
        return [@(((GameResult *)obj2).duration) compare:@(((GameResult *)obj1).duration)];
    }];
    
    [self updateUIWithResults:resultArray];
}
@end
