//
//  Action_RemoteConfig.h
//  CZMediator
//
//  Created by juyiwei on 2019/12/13.
//  Copyright © 2019 居然是村长. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Action_RemoteConfig : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSDictionary *actions;

@end

NS_ASSUME_NONNULL_END
