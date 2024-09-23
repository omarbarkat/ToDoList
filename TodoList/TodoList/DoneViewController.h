//
//  DoneViewController.h
//  MealsWorkshop
//
//  Created by eng.omar on 18/07/2024.
//

#import <UIKit/UIKit.h>
#import "ToDoDatabase.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<ToDoDatabase *> *arr;
@property (strong, nonatomic) NSMutableArray<ToDoDatabase *> *filteredTodos;

@end

NS_ASSUME_NONNULL_END
