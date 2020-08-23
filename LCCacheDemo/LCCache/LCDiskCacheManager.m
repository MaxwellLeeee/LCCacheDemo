//
//  LCDiskCacheManager.m
//  LCCacheDemo
//
//  Created by 李畅 on 2020/8/23.
//  Copyright © 2020 李畅. All rights reserved.
//

#import "LCDiskCacheManager.h"
#import "MMKV.h"
#import "LCDiskCacheKeyManager.h"

@interface LCDiskCacheManager()
{
    MMKV *_kv;
    NSMapTable *_globalInstances;
    dispatch_semaphore_t _globalInstancesLock;
}

@end

@implementation LCDiskCacheManager

#pragma mark - Interface API

- (BOOL)setObject:(nullable NSObject<NSCoding> *)object forKey:(NSString *)key
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setObject:object forKey:key];
}

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setBool:value forKey:key];
}

- (BOOL)setInt32:(int32_t)value forKey:(NSString *)key
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setInt32:value forKey:key];
}

- (BOOL)setUInt32:(uint32_t)value forKey:(NSString *)key
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setUInt32:value forKey:key];
}

- (BOOL)setInt64:(int64_t)value forKey:(NSString *)key
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setInt64:value forKey:key];
}

- (BOOL)setUInt64:(uint64_t)value forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setUInt64:value forKey:key];
}

- (BOOL)setFloat:(float)value forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setFloat:value forKey:key];
}

- (BOOL)setDouble:(double)value forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setDouble:value forKey:key];
}

- (BOOL)setString:(NSString *)value forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setString:value forKey:key];
}

- (BOOL)setDate:(NSDate *)value forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setDate:value forKey:key];
}

- (BOOL)setData:(NSData *)value forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv setData:value forKey:key];
}

- (nullable id)getObjectOfClass:(Class)cls forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getObjectOfClass:cls forKey:key];
}

- (BOOL)getBoolforKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getBoolForKey:key];
}

- (BOOL)getBoolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getBoolForKey:key defaultValue:defaultValue];
}

- (int32_t)getInt32forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getInt32ForKey:key];
}

- (int32_t)getInt32ForKey:(NSString *)key defaultValue:(int32_t)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getInt32ForKey:key defaultValue:defaultValue];
}

- (uint32_t)getUInt32forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getUInt32ForKey:key];
}
- (uint32_t)getUInt32ForKey:(NSString *)key defaultValue:(uint32_t)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getUInt32ForKey:key defaultValue:defaultValue];
}

- (int64_t)getInt64forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getInt64ForKey:key];
}

- (int64_t)getInt64ForKey:(NSString *)key defaultValue:(int64_t)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getInt64ForKey:key defaultValue:defaultValue];
}

- (uint64_t)getUInt64forKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getUInt64ForKey:key];
}

- (uint64_t)getUInt64ForKey:(NSString *)key defaultValue:(uint64_t)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getUInt64ForKey:key defaultValue:defaultValue];
}

- (float)getFloatforKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getFloatForKey:key];
}

- (float)getFloatForKey:(NSString *)key defaultValue:(float)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getFloatForKey:key defaultValue:defaultValue];
}

- (double)getDoubleforKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getDoubleForKey:key];
}
- (double)getDoubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getDoubleForKey:key defaultValue:defaultValue];
}

- (nullable NSString *)getStringforKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getStringForKey:key];
}

- (nullable NSString *)getStringForKey:(NSString *)key defaultValue:(nullable NSString *)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getStringForKey:key defaultValue:defaultValue];
}

- (nullable NSDate *)getDateforKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getDateForKey:key];
}
- (nullable NSDate *)getDateForKey:(NSString *)key defaultValue:(nullable NSDate *)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getDateForKey:key defaultValue:defaultValue];
}

- (nullable NSData *)getDataforKey:(NSString *)key{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getDataForKey:key];
}

- (nullable NSData *)getDataForKey:(NSString *)key defaultValue:(nullable NSData *)defaultValue
{
    [[LCDiskCacheKeyManager sharedInstance] _dbUpdateAccessTimeWithKey:key];
    return [_kv getDataForKey:key defaultValue:defaultValue];
}

#pragma mark - logic

static LCDiskCacheManager *manager = nil;
+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LCDiskCacheManager alloc] init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _globalInstancesLock = dispatch_semaphore_create(1);
        _globalInstances = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
    }
    return self;
}

-(BOOL)removeItemsToFitSize:(int)maxSize
{
    if (maxSize == INT_MAX){
        return YES;
    }
    if (maxSize <= 0){
        [self removeAllItems];
        return YES;
    }
    size_t total = [_kv totalSize];
    if (total < 0) {
        return NO;
    }
    if (total < maxSize) {
        return YES;
    }
    NSArray *items = nil;
    BOOL suc = NO;
    do {
        int perCount = 16;
        items = [[LCDiskCacheKeyManager sharedInstance] getCachedKeysWithCount:perCount];
        for (LCDiskCacheKeyObject *item in items) {
            if (total > maxSize) {
                size_t itemSize = 0;
                if (item.key) {
                    itemSize = [_kv getValueSizeForKey:item.key];
                    [_kv removeValueForKey:item.key];
                }
                suc = [[LCDiskCacheKeyManager sharedInstance] _dbDeleteItemWithKey:item.key];
                total -= itemSize;
            } else {
                break;
            }
            if (!suc) break;
        }
    } while (total > maxSize && items.count > 0 && suc);
    if (suc) {
        [[LCDiskCacheKeyManager sharedInstance] _dbCheckpoint];
    }
    return suc;
}

- (BOOL)removeItemsToFitCount:(int)maxCount {
    if (maxCount == INT_MAX) {
        return YES;
    }
    if (maxCount <= 0) {
        [self removeAllItems];
        return YES;
    }
    
    size_t total = [_kv count];
    if (total < 0) {
        return NO;
    }
    if (total <= maxCount) {
        return YES;
    }
    
    NSArray *items = nil;
    BOOL suc = NO;
    do {
        int perCount = 16;
        items = [[LCDiskCacheKeyManager sharedInstance] getCachedKeysWithCount:perCount];
        for (LCDiskCacheKeyObject *item in items) {
            if (total > maxCount) {
                if (item.key) {
                    [_kv removeValueForKey:item.key];
                }
                suc = [[LCDiskCacheKeyManager sharedInstance] _dbDeleteItemWithKey:item.key];
                total--;
            } else {
                break;
            }
            if (!suc) break;
        }
    } while (total > maxCount && items.count > 0 && suc);
    if (suc) {
        [[LCDiskCacheKeyManager sharedInstance] _dbCheckpoint];
    }
    return suc;
}

-(void)removeAllItems
{
    [_kv clearAll];
    [[LCDiskCacheKeyManager sharedInstance] removeAllItems];
}

@end
