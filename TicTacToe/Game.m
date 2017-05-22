//
//  Game.m
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import "Game.h"
#import "Player.h"

@implementation Game

+ (instancetype)gameWithPlayerOne:(Player *)playerOne playerTwo:(Player *)playerTwo andStartingPlayer:(Player *)startingPlayer {
    Game *newGame = [[Game alloc] init];
    newGame.playerOne = playerOne;
    newGame.playerTwo = playerTwo;
    newGame.currentPlayer = startingPlayer;
    newGame.currentState = Ongoing;
    newGame.board = [NSMutableArray arrayWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil];
    return newGame;
}

+(instancetype)gameWithPlayerOne:(Player *)playerOne playerTwo:(Player *)playerTwo currentPlayer:(Player *)currentPlayer andBoard:(NSArray *)board {
    Game *newGame = [[Game alloc] init];
    newGame.playerOne = playerOne;
    newGame.playerTwo = playerTwo;
    newGame.currentPlayer = currentPlayer;
    newGame.board = [NSMutableArray arrayWithArray:board];
    [newGame updateGameState];
    return newGame;

}

- (void)makeMove:(NSUInteger)position {
    if (_currentState != Ongoing) { return; }
    if ([_board[position] isEqual:[NSNull null]]) {
        _board[position] = _currentPlayer;
        [self passTurn];
        [self updateGameState];
    }
}

- (void)updateGameState {
    if ([self winningSquaresForPlayer:_playerOne] != nil) {
        if (_playerOne.symbol == Cross) {
            self.currentState = CrossesWon;
        } else {
            self.currentState = CirclesWon;
        }
    } else if ([self winningSquaresForPlayer:_playerTwo] != nil) {
        if (_playerTwo.symbol == Cross) {
            self.currentState = CrossesWon;
        } else {
            self.currentState = CirclesWon;
        }
    } else if ([self areThereMovesAvailable]) {
        self.currentState = Ongoing;
    } else {
        self.currentState = Draw;
    }
}

- (void)passTurn {
    _currentPlayer = _currentPlayer == _playerOne ? _playerTwo : _playerOne;
}

- (NSArray*)winningSquaresForPlayer:(Player*)player {
    for (int i = 0; i < 3; i++) {
        if (_board[i * 3] == player &&
            _board[1 + i * 3] == player &&
            _board[2 + i * 3] == player) {
            return @[@(i*3),@(1 + i * 3),@(2 + i * 3)];
        }
    }
    
    for (int i = 0; i < 3; i++) {
        if (_board[i] == player &&
            _board[i + 3] == player &&
            _board[i + 6] == player) {
            return @[@(i),@(i+3),@(i+6)];
        }
    }
    
    if (_board[0] == player &&
        _board[4] == player &&
        _board[8] == player) {
        return @[@(0),@(4),@(8)];
    } else if (_board[2] == player &&
               _board[4] == player &&
               _board[6] == player) {
        return @[@(2),@(4),@(6)];
    }
    return nil;
}

- (BOOL)areThereMovesAvailable {
    for (id square in _board) {
        if ([square isEqual:[NSNull null]]) {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)getWinningSquares {
    NSArray *squares = [self winningSquaresForPlayer:_playerOne];
    if (squares != nil) {
        return squares;
    } else {
        return [self winningSquaresForPlayer:_playerTwo];
    }
}

- (NSArray *)possibleMoves {
    int idx = 0;
    NSMutableArray *moves = [NSMutableArray new];
    for (id square in _board) {
        if ([square isEqual:[NSNull null]]) {
            [moves addObject:@(idx)];
        }
        idx++;
    }
    return moves;
}

- (BOOL)isItNewGame {
    return [self possibleMoves].count == 9;
}

@end
