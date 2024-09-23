//
//  MealsDatabase.m
//  MealsWorkshop
//
//  Created by eng.omar on 16/07/2024.
//

#import "ToDoDatabase.h"

@implementation ToDoDatabase 


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_imgTodo forKey:@"img" ];
    [coder encodeObject:_toDoDiscreption forKey:@"toDoDiscreption"];
     [coder encodeInteger:_todoPeriorty forKey:@"priority"];
     [coder encodeInteger:_todoType forKey:@"todoType"];
     [coder encodeObject:_date forKey:@"date"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        _name = [decoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _imgTodo = [decoder decodeObjectOfClass:[NSString class] forKey:@"img"];
        _toDoDiscreption = [decoder decodeObjectOfClass:[NSString class] forKey:@"toDoDiscreption"];
              _todoPeriorty = [decoder decodeIntegerForKey:@"priority"];
              _todoType = [decoder decodeIntegerForKey:@"todoType"];
              _date = [decoder decodeObjectOfClass:[NSDate class] forKey:@"date"];
    }
    return  self;
}
+ (BOOL)supportsSecureCoding {
    return true;
}
//-(id) init{
//    _name = @"hhh";
//    return  self;
//}
@end
