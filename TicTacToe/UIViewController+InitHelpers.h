//
//  UIViewController+InitHelpers.h
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (InitHelpers)
+ (instancetype)initFromStoryboardOfSameName;
+ (instancetype)initFromXib;
@end
