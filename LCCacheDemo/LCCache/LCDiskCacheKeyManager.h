//
//  LCDiskCacheKeyManager.h
//  LCCacheDemo
//
//  Created by 李畅 on 2020/8/23.
//  Copyright © 2020 李畅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDiskCacheKeyObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCDiskCacheKeyManager : NSObject

+(instancetype)sharedInstance;
-(NSArray *)getCachedKeysWithCount:(NSInteger)count;
-(void)deleteCachedKeys:(NSArray *)keys;
- (BOOL)_dbDeleteItemWithKey:(NSString *)key;
- (BOOL)_dbUpdateAccessTimeWithKey:(NSString *)key;
- (void)_dbCheckpoint;
- (BOOL)removeAllItems;

@end

NS_ASSUME_NONNULL_END
