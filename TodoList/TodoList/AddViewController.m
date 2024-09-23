//
//  AddViewController.m
//  MealsWorkshop
//
//  Created by eng.omar on 17/07/2024.
//

#import "AddViewController.h"
#import "ToDoDatabase.h"
#import "ViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentPriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentType;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *btnAdd;
//@property NSMutableArray *arr;
@property (weak, nonatomic) IBOutlet UIButton *btnTitle;

@end

@implementation AddViewController
//bool _isCreation = true;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if ((_isCreation)) {
        _btnTitle.titleLabel.text = @"Add";
        [self.segmentType setEnabled:false forSegmentAtIndex:1];
        [self.segmentType setEnabled:false forSegmentAtIndex:2];
    } else {
//        [self.segmentType setEnabled:false forSegmentAtIndex:2];

        printf("update");
        ToDoDatabase *todo = [ToDoDatabase new];
        todo = _arr;
        _txtFieldTitle.text = todo.name;
        _txtDescription.text = todo.toDoDiscreption;
        _segmentPriority.selectedSegmentIndex = todo.todoPeriorty;
        _segmentType.selectedSegmentIndex = todo.todoType;
        _datePicker.date = todo.date;
//        [_arr replaceObjectAtIndex:_index withObject:todo];
        [_arr2 replaceObjectAtIndex:_index withObject:todo];
        
    }
   
    if (_segmentPriority.selectedSegmentIndex == 0) {
        self.imgType.image = [UIImage imageNamed:@"img3"];
    } else {
        if (_segmentPriority.selectedSegmentIndex == 1) {
            self.imgType.image = [UIImage imageNamed:@"img1"];

        }else {

            self.imgType.image = [UIImage imageNamed:@"img2"];

        }
    }
    // Load existing todos from UserDefaults
    NSData *retrievedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"arrTodos"];
    if (retrievedData) {
        NSSet *set = [NSSet setWithArray:@[[NSArray class], [ToDoDatabase class]]];
        NSError *error;
        _arr = (NSMutableArray *)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:retrievedData error:&error];
        if (!_arr) {
            _arr = [NSMutableArray new];
        }
    } else {
        _arr = [NSMutableArray new];
    }
 

}
- (void)viewWillAppear:(BOOL)animated {
//    if (_isCreation) {
//        printf("true");
//    } else {
//        printf("false");
//    }
}

- (IBAction)btnAdd:(id)sender {
    
    if ((_isCreation)) {
        if (_txtFieldTitle.text.length == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"you must fill Title text field" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:NULL];
            [alert addAction:dismiss];
            [self presentViewController:alert animated:true completion:NULL];
        } else {
            ToDoDatabase *todo = [ToDoDatabase new];
            todo.name = _txtFieldTitle.text;
            todo.toDoDiscreption = _txtDescription.text;
            todo.todoPeriorty = _segmentPriority.selectedSegmentIndex;

            if (_segmentType.selectedSegmentIndex == 0) {
                todo.todoType = 0;
            } else {
                if (_segmentType.selectedSegmentIndex == 1) {
                    todo.todoType = 1;
                }else {
                    todo.todoType = 2;

                }
            }
    //        todo.todoType = _segmentType.selectedSegmentIndex;
            todo.date = _datePicker.date;
    //x        printf("%ld",todo.todoType);
            // Add the new todo to the array
            
            [_arr addObject:todo];
//            [_arr replaceObjectAtIndex:_index withObject:todo];
            
            NSError *error;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_arr requiringSecureCoding:YES error:&error];
            if (error) {
                NSLog(@"Error archiving data: %@", error.localizedDescription);
                return;
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"arrTodos"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Add Success" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                [self.navigationController popViewControllerAnimated:true];
                
            }];
            UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:NULL];
            [alert addAction:confirm];
            [alert addAction:dismiss];
            [self presentViewController:alert animated:true completion:NULL];
        }
    }else {
        ToDoDatabase *todo = [ToDoDatabase new];
        todo.name = _txtFieldTitle.text;
        todo.toDoDiscreption = _txtDescription.text;
        todo.todoPeriorty = _segmentPriority.selectedSegmentIndex;

//        if (_segmentType.selectedSegmentIndex == 0) {
//            todo.todoType = 0;
//        } else {
//            if (_segmentType.selectedSegmentIndex == 1) {
//                todo.todoType = 1;
//            }else {
//                todo.todoType = 2;
//
//            }
//        }
        todo.todoType = _segmentType.selectedSegmentIndex;
        todo.date = _datePicker.date;
//x        printf("%ld",todo.todoType);
        // Add the new todo to the array
        
//            [_arr addObject:todo];
        [_arr replaceObjectAtIndex:_index withObject:todo];
        
        NSError *error;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_arr requiringSecureCoding:YES error:&error];
        if (error) {
            NSLog(@"Error archiving data: %@", error.localizedDescription);
            return;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"arrTodos"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Add Success" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            [self.navigationController popViewControllerAnimated:true];
            
            
        }];
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:NULL];
        [alert addAction:confirm];
        
        [alert addAction:dismiss];
        [self presentViewController:alert animated:true completion:NULL];
    }

 
        

    
    
  
}



    

@end
