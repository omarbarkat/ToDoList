//
//  AddViewController.h
//  MealsWorkshop
//
//  Created by eng.omar on 17/07/2024.
//

#import <UIKit/UIKit.h>
#import "ToDoDatabase.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController
@property bool isCreation;
@property NSMutableArray<ToDoDatabase*>* arr;
@property NSMutableArray<ToDoDatabase*>* arr2;;
@property NSInteger index;
@end

NS_ASSUME_NONNULL_END
