//
//  DoneViewController.m
//  MealsWorkshop
//
//  Created by eng.omar on 18/07/2024.
//

#import "DoneViewController.h"

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgDefualt;
@property bool isSort;
//@property (strong, nonatomic) NSMutableArray<ToDoDatabase *> *arr;
//@property (strong, nonatomic) NSMutableArray<ToDoDatabase *> *filteredTodos;

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.imgDefualt.hidden = YES; // بدلًا من استخدام isHidden == false
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadTodos];
    [self filterTodos];
    [self.tableView reloadData];
}

- (void)loadTodos {
    NSData *retrievedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"arrTodos"];
    if (retrievedData) {
        NSSet *set = [NSSet setWithArray:@[[NSArray class], [ToDoDatabase class]]];
        NSError *error;
        self.arr = (NSMutableArray *)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:retrievedData error:&error];
        if (!self.arr) {
            self.arr = [NSMutableArray new];
        }
    } else {
        self.arr = [NSMutableArray new];
    }
}

- (void)filterTodos {
    self.filteredTodos = [NSMutableArray new];
    for (ToDoDatabase *todo in self.arr) {
        if (todo.todoType == 2) {
            [self.filteredTodos addObject:todo];
        }
    }
    self.imgDefualt.hidden = (self.filteredTodos.count > 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredTodos.count;
}

- (IBAction)btnSort:(id)sender {
    self.isSort = !self.isSort; // عكس القيمة الحالية
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doneCell" forIndexPath:indexPath];
    ToDoDatabase *todo = self.filteredTodos[indexPath.row];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Low";
        case 1:
            return @"Medium";
        case 2:
            return @"High";
        default:
            return @"";
    }
}

@end
