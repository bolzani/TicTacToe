//
//  Game.h
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Player;

typedef enum : NSUInteger {
    CrossesWon,
    CirclesWon,
    Draw,
    Ongoing
} GameState;

typedef enum : NSUInteger {
    CrossSquare,
    CircleSquare,
    EmptySquare,
} SquareState;

@interface Game : NSObject

@property (nonatomic, strong) Player *playerOne;
@property (nonatomic, strong) Player *playerTwo;
@property (nonatomic, weak) Player *currentPlayer;
@property (nonatomic, assign) GameState currentState;
@property (nonatomic, strong) NSMutableArray *board;

+ (instancetype)gameWithPlayerOne:(Player*)playerOne
                        playerTwo:(Player*)playerTwo
                andStartingPlayer:(Player*)startingPlayer;

+ (instancetype)gameWithPlayerOne:(Player*)playerOne
                        playerTwo:(Player*)playerTwo
                    currentPlayer:(Player*)currentPlayer
                         andBoard:(NSArray*)board;

- (void) makeMove:(NSUInteger)position;
- (NSArray*)getWinningSquares;
- (NSArray*)possibleMoves;
- (BOOL)isItNewGame;
@end
