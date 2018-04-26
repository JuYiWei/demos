//
//  Person.m
//  FunctionProgrammingDemo
//
//  Created by 居祎炜 on 2018/4/26.
//  Copyright © 2018年 居祎炜. All rights reserved.
//

#import "Person.h"

@interface Person()
@property (nonatomic, strong) NSMutableArray *infoList;
@end

@implementation Person

- (NSMutableArray *)infoList {
    if (!_infoList) {
        _infoList = [NSMutableArray array];
    }
    return _infoList;
}

+ (NSString *)makeMessage:(void(^)(Person *person))block {
    if (block) {
        Person *person = [[Person alloc] init];
        block(person);
        return [person.infoList componentsJoinedByString:@","];
    }
    return nil;
}

- (eatBlock)eat {
    return ^Person* (NSString *a) {
        NSLog(@"吃了：%@",a);
        [self.infoList addObject:[NSString stringWithFormat:@"吃了 %@", a]];
        return self;
    };
}

- (runBlock)run {
    return ^Person *(NSInteger step) {
        NSLog(@"走了：%zi 步", step);
        [self.infoList addObject:[NSString stringWithFormat:@"走了 %zi 步", step]];
        return self;
    };
}

- (Person *)pause {
    NSLog(@"休息一下");
    [self.infoList addObject:@"休息以下"];
    return self;
}

@end
