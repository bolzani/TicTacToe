//
//  GameViewController.m
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (nonatomic, strong) Game *currentGame;
@property (weak, nonatomic) IBOutlet UIButton *btnRematch;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Jogo da Velha";
    [self newGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)updateInterfaceForGame:(Game*)game {
    [self updateStatusStringForGame:game];
    [self updateBoardForGame:game];
    if (game.currentState != Ongoing) {
        [UIView animateWithDuration:0.3 animations:^{
            self.btnRematch.alpha = 1.0;
        }];
    } else {
        self.btnRematch.alpha = 0.0;
    }
}

- (void)updateStatusStringForGame:(Game*)game {
    if (self.currentGame.currentState == Ongoing) {
        if (self.currentGame.currentPlayer.isAi) {
            self.lblStatus.text = @"Vez do computador";
        } else if (self.currentGame.currentPlayer.symbol == Cross) {
            self.lblStatus.text = @"Vez do 'X'";
        } else {
            self.lblStatus.text = @"Vez do 'O'";
        }
    } else if (self.currentGame.currentState == CrossesWon) {
        self.lblStatus.text = @"'X' ganhou!";
    } else if (self.currentGame.currentState == CirclesWon) {
        self.lblStatus.text = @"'O' ganhou!";
    } else {
        self.lblStatus.text = @"Empatou!";
    }
}

- (void)updateBoardForGame:(Game*)game {
    int counter = 0;
    for (id square in game.board) {
        if ([square isKindOfClass:[Player class]]) {
            for (UIButton* button in self.buttons) {
                if (button.tag == counter) {
                    if (((Player*)square).symbol == Cross) {
                        [button setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
                    } else {
                        [button setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
                    }
                }
            }
        }
        counter++;
    }
    
    if (self.currentGame.currentState != Ongoing) {
        [self highlightWinningSquares];
    }
}

- (void)performAiMove {
    self.view.userInteractionEnabled = false;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
        [self.currentGame makeMove:[self.currentGame.currentPlayer bestMoveForGame:self.currentGame]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateInterfaceForGame:self.currentGame];
            self.view.userInteractionEnabled = true;
        });
    });
}

- (void)highlightWinningSquares {
    NSArray *winningSquares = [self.currentGame getWinningSquares];
    if (winningSquares != nil) {
        for (NSNumber *square in winningSquares) {
            for (UIButton* button in self.buttons) {
                if (button.tag == [square integerValue]) {
                    button.tintColor = [UIColor redColor];
                }
            }
        }
    } else {
        for (UIButton* button in self.buttons) {
            button.tintColor = [UIColor redColor];
        }
    }
}

- (void)newGame {
    self.currentGame = [Game gameWithPlayerOne:self.playerOne
                                     playerTwo:self.playerTwo
                             andStartingPlayer:self.startingPlayer];
    for (UIButton* button in self.buttons) {
        button.tintColor = [UIColor blackColor];
        [button setImage:nil forState:UIControlStateNormal];
    }
    [self updateInterfaceForGame:self.currentGame];
    if (self.currentGame.currentPlayer.isAi) {
        [self performAiMove];
    }
}

- (IBAction)didTapSquare:(UIButton *)sender {
    [self.currentGame makeMove:sender.tag];
    [self updateInterfaceForGame:self.currentGame];
    if (self.currentGame.currentPlayer.isAi) {
        [self performAiMove];
    }
}

- (IBAction)didPressRematch:(UIButton *)sender {
    [self newGame];
}

@end
