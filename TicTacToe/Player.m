//
//  Player.m
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import "Player.h"
#import "Game.h"

@implementation Player
- (instancetype)initWithSymbol:(Symbol)symbol {
    self = [self init];
    if (self) {
        _symbol = symbol;
        _difficulty = Invincible;
    }
    return self;
}

- (NSUInteger)bestMoveForGame:(Game *)game {
    
    if ([game isItNewGame]) {
        return arc4random_uniform(9);
    }

    int bestScore = -1000;
    NSUInteger bestMove = 0;
    NSArray *possibleMoves = [game possibleMoves];
    if ((_difficulty == Medium && arc4random_uniform(10) >= 7) || _difficulty == Easy) {
        bestMove = [possibleMoves[arc4random_uniform((int)possibleMoves.count-1)] integerValue];
    } else {
        for (NSNumber *move in possibleMoves) {
            Game *currentGame = [Game gameWithPlayerOne:game.playerOne
                                              playerTwo:game.playerTwo
                                          currentPlayer:game.currentPlayer
                                               andBoard:game.board];
            NSInteger position = [move integerValue];
            [currentGame makeMove:position];
            int score = [self bestScoreForGame:currentGame];
            if (score > bestScore) {
                bestScore = score;
                bestMove = [move integerValue];
            }
        }
    }
    return bestMove;
}

- (int)bestScoreForGame:(Game*)game {
    if (game.currentState != Ongoing) {
        return [self scoreForGame:game];
    }
    NSMutableArray *scores = [NSMutableArray new];
    for (NSNumber *move in [game possibleMoves]) {
        Game *currentGame = [Game gameWithPlayerOne:game.playerOne
                                          playerTwo:game.playerTwo
                                      currentPlayer:game.currentPlayer
                                           andBoard:game.board];
        NSInteger position = [move integerValue];
        [currentGame makeMove:position];
        [scores addObject:@([self bestScoreForGame:currentGame])];
    }
    
    int bestScore = [[scores firstObject] intValue];
    for (NSNumber *score in scores) {
        int currentScore = [score intValue];
        if (self == game.currentPlayer) {
            if (currentScore > bestScore) {
                bestScore = currentScore;
            }
        } else {
            if (currentScore < bestScore) {
                bestScore = currentScore;
            }
        }
    }
    
    return  bestScore;
}


- (int)scoreForGame:(Game*)game {
    if (game.currentState == CrossesWon) {
        return (self.symbol == Cross) ? 10 : -10;
    } else if (game.currentState == CirclesWon) {
        return (self.symbol == Circle) ? 10 : -10;
    } else {
        return 0;
    }
}

@end
