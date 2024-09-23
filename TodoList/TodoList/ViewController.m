//
//  ViewController.m
//  todosWorkshop
//
//  Created by eng.omar on 16/07/2024.
//

#import "ViewController.h"
#import "ToDoDatabase.h"
#import "AddViewController.h"

@interface ViewController ()
//@property NSUserDefaults* defualts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray<ToDoDatabase *> *arrTodos;
@property (strong, nonatomic) NSMutableArray<ToDoDatabase *> *filteredTodos;
@property (strong, nonatomic) NSMutableArray<ToDoDatabase *> *todoFilterData;

@property (nonatomic) BOOL isFiltered;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTodos];
    
    if (!self.arrTodos) {
        self.arrTodos = [NSMutableArray new];
        
//        ToDoDatabase *todo1 = [ToDoDatabase new];
//        todo1.name = @"task1";
//        todo1.imgTodo = @"img1";
//        [self.arrTodos addObject:todo1];
        
        [self saveTodos];
    }

    self.filteredTodos = [NSMutableArray arrayWithArray:self.arrTodos];
    self.isFiltered = NO;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    [self todoFilter];
}
-(void)todoFilter{
    self.todoFilterData = [NSMutableArray new];
    for (ToDoDatabase* todo in self.arrTodos) {
        if (todo.todoType == 0) {
            [self.todoFilterData addObject:todo];
        }
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadTodos];
    self.filteredTodos = [NSMutableArray arrayWithArray:self.arrTodos];
    [self.tableView reloadData];
}

- (IBAction)btnAddTodo:(id)sender {
    AddViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    vc.isCreation = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isFiltered = NO;
        self.filteredTodos = [NSMutableArray arrayWithArray:self.todoFilterData];
    } else {
        self.isFiltered = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[c] %@", searchText];
        self.filteredTodos = [NSMutableArray arrayWithArray:[self.todoFilterData filteredArrayUsingPredicate:predicate]];
    }
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ToDoDatabase *todo = self.isFiltered ? self.filteredTodos[indexPath.row] : self.todoFilterData[indexPath.row];
    cell.textLabel.text = todo.name;

    switch (todo.todoPeriorty) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"img3"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"img1"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"img2"];
            break;
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isFiltered ? self.filteredTodos.count : self.todoFilterData.count;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self.todoFilterData removeObjectAtIndex:indexPath.row];
        [self saveTodos];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        completionHandler(YES);
    }];
    
    UIContextualAction *update = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Update" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        AddViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
        vc.isCreation = NO;
        vc.arr = self.todoFilterData[indexPath.row];
        vc.index = indexPath.row;
        vc.arr2 = self.todoFilterData;
        [self.navigationController pushViewController:vc animated:YES];
        completionHandler(YES);
    }];
    update.backgroundColor = [UIColor blueColor];

    UISwipeActionsConfiguration *swipe = [UISwipeActionsConfiguration configurationWithActions:@[delete, update]];
    swipe.performsFirstActionWithFullSwipe = NO;
    return swipe;
}

- (void)saveTodos {
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.todoFilterData requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"Error archiving data: %@", error.localizedDescription);
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"arrTodos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadTodos {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"arrTodos"];
    if (data) {
        NSError *error;
        NSSet *set = [NSSet setWithArray:@[[NSArray class], [ToDoDatabase class]]];
        self.todoFilterData = (NSMutableArray *)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:data error:&error];
        if (error) {
            NSLog(@"Error unarchiving data: %@", error.localizedDescription);
        }
    }
}

@end
