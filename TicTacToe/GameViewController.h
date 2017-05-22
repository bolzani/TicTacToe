//
//  GameViewController.h
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+InitHelpers.h"
#import "Player.h"
#import "Game.h"

@interface GameViewController : UIViewController

@property (nonatomic, strong) Player *playerOne;
@property (nonatomic, strong) Player *playerTwo;
@property (nonatomic, weak) Player *startingPlayer;
@end
