//
//  MealsDatabase.h
//  MealsWorkshop
//
//  Created by eng.omar on 16/07/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoDatabase : NSObject <NSCoding, NSSecureCoding>

@property NSString* name;
@property NSString* imgTodo;
@property NSString* img;
@property NSString* toDoDiscreption;
@property (nonatomic, assign) NSInteger todoPeriorty;
@property (nonatomic, assign) NSInteger todoType;
@property NSDate* date;

//-(id) init;
    



- (void)encodeWithCoder:(NSCoder *)coder;


@end

NS_ASSUME_NONNULL_END
