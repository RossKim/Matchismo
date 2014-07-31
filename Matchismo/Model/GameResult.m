//
//  GameResult.m
//  Matchismo
//
//  Created by Kim Minsu on 2013/04/28.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()

@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@property (readwrite, nonatomic) int mode;      //1 : Card, 2 : Set
@property (readwrite, nonatomic) int score;

@end

@implementation GameResult

#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define MODE_KEY @"Mode"
#define ALL_RESULTS_KEY @"GameResults_All"

+ (NSArray *)allGameResults {
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    for(id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    };
    return allGameResults;
}

// convenience initializer
- (id)initFromPropertyList:(id)plist {
    self = [self init];
    if(self) {
        if([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            _mode = [resultDictionary[MODE_KEY] intValue];
            if(!_start || !_end) {
                self = nil;
            }
        }
    }
    return self;
}

- (id)asPropertyList {
    return @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score), MODE_KEY : @(self.mode)};
}

- (void)synchronize {
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if(!mutableGameResultsFromUserDefaults) {
        mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// designate initializer
- (id)init {
    self = [super init];
    if(self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (NSTimeInterval)duration {
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setGame:(NSUInteger)score mode:(NSUInteger)mode {
    self.score = score;
    self.mode = mode;
    self.end = [NSDate date];
    [self synchronize];
}

@end
