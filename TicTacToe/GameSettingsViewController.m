//
//  GameSettingsViewController.m
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import "GameSettingsViewController.h"
#import "GameViewController.h"
#import "Player.h"
#import "Game.h"

@interface GameSettingsViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *cellSymbolX;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellSymbolO;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellFirstPlayerYou;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellFirstPlayerOther;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellFirstPlayerRandom;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDifficultyEasy;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDifficultyMedium;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellDifficultyInvincible;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellsSectionOne;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellsSectionTwo;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cellsSectionThree;



@property (weak, nonatomic) IBOutlet UILabel *lblPlayerSymbol;
@property (weak, nonatomic) IBOutlet UILabel *lblStartingPlayer;
@property (weak, nonatomic) IBOutlet UILabel *lblDifficulty;
@property (nonatomic, strong) Player *playerOne;
@property (nonatomic, strong) Player *playerTwo;
@property (nonatomic, weak) Player *startingPlayer;
@end

@implementation GameSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Configurações";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Iniciar"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(beginGame)];
    _playerOne = [[Player alloc] initWithSymbol:Cross];
    _playerTwo = [[Player alloc] initWithSymbol:Circle];
    _playerTwo.isAi = self.isVsAi;
    _startingPlayer = _playerOne;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)beginGame {
    GameViewController *gameViewController = [GameViewController initFromXib];
    [self configurePlayersFromSelections];
    gameViewController.playerOne = _playerOne;
    gameViewController.playerTwo = _playerTwo;
    gameViewController.startingPlayer = _startingPlayer;
    [self.navigationController pushViewController:gameViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.isVsAi ? 3 : 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            [self selectCellAtIndex:indexPath.row fromCollection:_cellsSectionOne];
            break;
        case 1:
            [self selectCellAtIndex:indexPath.row fromCollection:_cellsSectionTwo];
            break;
        case 2:
            [self selectCellAtIndex:indexPath.row fromCollection:_cellsSectionThree];
            break;
        default: break;
    }
}

- (void)selectCellAtIndex:(NSInteger)index fromCollection:(NSArray*)collection {
    for (UITableViewCell* cell in collection) {
        if (cell.tag == index) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (NSInteger)getSelectedIndexFromCollection:(NSArray*)collection {
    NSInteger index = 0;
    for (UITableViewCell* cell in collection) {
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            return index;
        } else {
            index++;
        }
    }
    return index;
}

- (void)configurePlayersFromSelections {
    [self configurePlayerSymbols];
    [self configureStartingPlayer];
    [self configureAiDifficulty];
}

- (void)configurePlayerSymbols {
    NSInteger index = [self getSelectedIndexFromCollection:_cellsSectionOne];
    if (index == 0) {
        _playerOne.symbol = Cross;
        _playerTwo.symbol = Circle;
    } else {
        _playerOne.symbol = Circle;
        _playerTwo.symbol = Cross;
    }
}

- (void)configureStartingPlayer {
    NSInteger index = [self getSelectedIndexFromCollection:_cellsSectionTwo];
    if (index == 0) {
        _startingPlayer = _playerOne;
    } else if (index == 1) {
        _startingPlayer = _playerTwo;
    } else {
        _startingPlayer = arc4random_uniform(2) == 0 ? _playerOne : _playerTwo;
    }
}

- (void)configureAiDifficulty {
    NSInteger index = [self getSelectedIndexFromCollection:_cellsSectionTwo];
    if (index == 0) {
        _playerTwo.difficulty = Easy;
    } else if (index == 1) {
        _playerTwo.difficulty = Medium;
    } else {
        _playerTwo.difficulty = Invincible;
    }
}

@end
