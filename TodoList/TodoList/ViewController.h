//
//  ViewController.h
//  MealsWorkshop
//
//  Created by eng.omar on 16/07/2024.
//

#import <UIKit/UIKit.h>
#import "ToDoDatabase.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>

@property NSMutableArray* arr;
//@property (nonatomic, strong) NSMutableArray<ToDoDatabase *> *filteredTodos;
//@property (nonatomic, assign) BOOL isFiltered;
@property (strong, nonatomic) NSMutableArray<ToDoDatabase *> *filteredTodo; 

@end

