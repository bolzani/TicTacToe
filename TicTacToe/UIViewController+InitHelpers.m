//
//  UIViewController+InitHelpers.m
//  TicTacToe
//
//  Created by Felipe Alves on 21/05/17.
//  Copyright © 2017 Bolzaniapps. All rights reserved.
//

#import "UIViewController+InitHelpers.h"

@implementation UIViewController (InitHelpers)

+ (instancetype)initFromStoryboardOfSameName {
    NSString * className = NSStringFromClass([self class]);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:className bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:className];
}

+ (instancetype)initFromXib {
    NSString * className = NSStringFromClass([self class]);
    return [[[self class] alloc] initWithNibName:className bundle:nil];
}

@end
