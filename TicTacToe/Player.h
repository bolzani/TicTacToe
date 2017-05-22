//
//  Player.h
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

typedef enum : NSUInteger {
    Cross,
    Circle
} Symbol;

typedef enum : NSUInteger {
    Invincible,
    Medium,
    Easy
} AIDifficulty;

@interface Player : NSObject
@property (nonatomic, assign) BOOL isAi;
@property (nonatomic, assign) Symbol symbol;
@property (nonatomic, assign) AIDifficulty difficulty;

- (instancetype)initWithSymbol:(Symbol)symbol;
- (NSUInteger)bestMoveForGame:(Game*)game;

@end
