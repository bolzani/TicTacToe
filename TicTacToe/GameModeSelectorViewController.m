//
//  GameModeSelectorViewController.m
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import "GameModeSelectorViewController.h"
#import "GameSettingsViewController.h"

@interface GameModeSelectorViewController ()

@end

@implementation GameModeSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Modo de Jogo";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)presentGameSettingsScreenVsAi:(BOOL)vsAi {
    GameSettingsViewController *gameSettings = [GameSettingsViewController initFromStoryboardOfSameName];
    gameSettings.isVsAi = vsAi;
    [self.navigationController pushViewController:gameSettings animated:YES];
}

- (IBAction)didPressTwoPlayers:(UIButton *)sender {
    [self presentGameSettingsScreenVsAi:NO];
}

- (IBAction)didPressVsAi:(UIButton *)sender {
    [self presentGameSettingsScreenVsAi:YES];
}

@end
