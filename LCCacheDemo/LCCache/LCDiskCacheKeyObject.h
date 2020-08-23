//
//  LCDiskCacheKeyObject.h
//  LCCacheDemo
//
//  Created by 李畅 on 2020/8/23.
//  Copyright © 2020 李畅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCDiskCacheKeyObject : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic) NSTimeInterval updateTime;

@end

NS_ASSUME_NONNULL_END
