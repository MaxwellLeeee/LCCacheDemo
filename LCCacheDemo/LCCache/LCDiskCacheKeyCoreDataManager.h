//
//  LCDiskCacheKeyCoreDataManager.h
//  LCCacheDemo
//
//  Created by 李畅 on 2020/8/24.
//  Copyright © 2020 李畅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCacheDemo-Swift.h"

@class DiskCacheKey;

NS_ASSUME_NONNULL_BEGIN

@interface LCDiskCacheKeyCoreDataManager : NSObject

-(DiskCacheKey *)insertKey:(NSString *)key;
-(void)deleteKey:(NSString *)key;
-(void)updateTimeInKey:(NSString *)key;
-(NSArray *)getKeysWithCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
