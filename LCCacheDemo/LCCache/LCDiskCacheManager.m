//
//  LCDiskCacheManager.m
//  LCCacheDemo
//
//  Created by 李畅 on 2020/8/23.
//  Copyright © 2020 李畅. All rights reserved.
//

#import "LCDiskCacheManager.h"
#import "MMKV.h"
#import "LCDiskCacheKeyCoreDataManager.h"

#define Lock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define Unlock() dispatch_semaphore_signal(self->_lock)

@class DiskCacheKey;

@interface LCDiskCacheManager()
{
    MMKV *_kv;
    dispatch_semaphore_t _lock;
    dispatch_queue_t _queue;
    LCDiskCacheKeyCoreDataManager *_manager;
}

@end

@implementation LCDiskCacheManager

#pragma mark - Interface API

- (BOOL)setObject:(nullable NSObject<NSCoding> *)object forKey:(NSString *)key
{
    BOOL succ =  [_kv setObject:object forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key
{
    BOOL succ =  [_kv setBool:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setInt32:(int32_t)value forKey:(NSString *)key
{
    BOOL succ =  [_kv setInt32:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setUInt32:(uint32_t)value forKey:(NSString *)key
{
    BOOL succ =  [_kv setUInt32:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setInt64:(int64_t)value forKey:(NSString *)key
{
    BOOL succ =  [_kv setInt64:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setUInt64:(uint64_t)value forKey:(NSString *)key{
    BOOL succ =  [_kv setUInt64:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setFloat:(float)value forKey:(NSString *)key{
    BOOL succ =  [_kv setFloat:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setDouble:(double)value forKey:(NSString *)key{
    BOOL succ =  [_kv setDouble:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setString:(NSString *)value forKey:(NSString *)key{
    BOOL succ = [_kv setString:value forKey:key];
    if (succ) {
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setDate:(NSDate *)value forKey:(NSString *)key{
    BOOL succ =  [_kv setDate:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (BOOL)setData:(NSData *)value forKey:(NSString *)key{
    BOOL succ =  [_kv setData:value forKey:key];
    if(succ){
        Lock();
        [_manager timeNeedChangeWithKey:key];
        Unlock();
    }
    return succ;
}

- (nullable id)getObjectOfClass:(Class)cls forKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getObjectOfClass:cls forKey:key];
}

- (BOOL)getBoolforKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getBoolForKey:key];
}

- (BOOL)getBoolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getBoolForKey:key defaultValue:defaultValue];
}

- (int32_t)getInt32forKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getInt32ForKey:key];
}

- (int32_t)getInt32ForKey:(NSString *)key defaultValue:(int32_t)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getInt32ForKey:key defaultValue:defaultValue];
}

- (uint32_t)getUInt32forKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getUInt32ForKey:key];
}

- (uint32_t)getUInt32ForKey:(NSString *)key defaultValue:(uint32_t)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getUInt32ForKey:key defaultValue:defaultValue];
}

- (int64_t)getInt64forKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getInt64ForKey:key];
}

- (int64_t)getInt64ForKey:(NSString *)key defaultValue:(int64_t)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getInt64ForKey:key defaultValue:defaultValue];
}

- (uint64_t)getUInt64forKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getUInt64ForKey:key];
}

- (uint64_t)getUInt64ForKey:(NSString *)key defaultValue:(uint64_t)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getUInt64ForKey:key defaultValue:defaultValue];
}

- (float)getFloatforKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getFloatForKey:key];
}

- (float)getFloatForKey:(NSString *)key defaultValue:(float)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getFloatForKey:key defaultValue:defaultValue];
}

- (double)getDoubleforKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getDoubleForKey:key];
}

- (double)getDoubleForKey:(NSString *)key defaultValue:(double)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getDoubleForKey:key defaultValue:defaultValue];
}

- (nullable NSString *)getStringforKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getStringForKey:key];
}

- (nullable NSString *)getStringForKey:(NSString *)key defaultValue:(nullable NSString *)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getStringForKey:key defaultValue:defaultValue];
}

- (nullable NSDate *)getDateforKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getDateForKey:key];
}

- (nullable NSDate *)getDateForKey:(NSString *)key defaultValue:(nullable NSDate *)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getDateForKey:key defaultValue:defaultValue];
}

- (nullable NSData *)getDataforKey:(NSString *)key{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
    return [_kv getDataForKey:key];
}

- (nullable NSData *)getDataForKey:(NSString *)key defaultValue:(nullable NSData *)defaultValue
{
    Lock();
    [_manager timeNeedChangeWithKey:key];
    Unlock();
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
        _manager = [LCDiskCacheKeyCoreDataManager new];
        _kv = [MMKV mmkvWithID:@"cfgroup_discache"];
        _lock = dispatch_semaphore_create(1);
        _queue = dispatch_queue_create("com.tencent.cache.disk", DISPATCH_QUEUE_CONCURRENT);
        _countLimit = NSUIntegerMax;
        _sizeLimit = NSUIntegerMax;
        _ageLimit = DBL_MAX;
        _freeDiskSpaceLimit = 0;
        [self tryToFindDeleteDiskCache];
    }
    return self;
}

-(void)tryToFindDeleteDiskCache
{
    __weak typeof(self) _self = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_autoTrimInterval * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        __strong typeof(_self) self = _self;
        if (!self) return;
        [self _trimInBackground];
        [self tryToFindDeleteDiskCache];
    });
}

- (void)_trimInBackground {
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        if (!self) return;
        Lock();
        [self _trimToCost:self.sizeLimit];
        [self _trimToCount:self.countLimit];
        [self _trimToAge:self.ageLimit];
        [self _trimToFreeDiskSpace:self.freeDiskSpaceLimit];
        Unlock();
    });
}

- (void)_trimToCost:(NSUInteger)costLimit {
    if (costLimit >= INT_MAX) return;
    [self removeItemsToFitSize:(int)costLimit];
    
}

- (void)_trimToCount:(NSUInteger)countLimit {
    if (countLimit >= INT_MAX) return;
    [self removeItemsToFitCount:(int)countLimit];
}

- (void)_trimToAge:(NSTimeInterval)ageLimit {
    if (ageLimit <= 0) {
        [self removeAllItems];
        return;
    }
    long timestamp = time(NULL);
    if (timestamp <= ageLimit) return;
    long age = timestamp - ageLimit;
    if (age >= INT_MAX) return;
    [self removeItemsEarlierThanTime:(int)age];
}

- (void)_trimToFreeDiskSpace:(NSUInteger)targetFreeDiskSpace {
    if (targetFreeDiskSpace == 0) return;
    int64_t totalBytes = [_kv totalSize];
    if (totalBytes <= 0) return;
    int64_t diskFreeBytes = [self getDiskFreeSpace];
    if (diskFreeBytes < 0) return;
    int64_t needTrimBytes = targetFreeDiskSpace - diskFreeBytes;
    if (needTrimBytes <= 0) return;
    int64_t costLimit = totalBytes - needTrimBytes;
    if (costLimit < 0) costLimit = 0;
    [self _trimToCost:(int)costLimit];
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
        items = [_manager getKeysWithCount:perCount];
        for (DiskCacheKey *item in items) {
            if (total > maxSize) {
                size_t itemSize = 0;
                if (item.key) {
                    itemSize = [_kv getValueSizeForKey:item.key];
                    [_kv removeValueForKey:item.key];
                }
                [_manager deleteKey:item.key];
                total -= itemSize;
                suc = YES;
            } else {
                break;
            }
            if (!suc) break;
        }
    } while (total > maxSize && items.count > 0 && suc);
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
        items = [_manager getKeysWithCount:perCount];
        for (DiskCacheKey *item in items) {
            if (total > maxCount) {
                if (item.key) {
                    [_kv removeValueForKey:item.key];
                }
                [_manager deleteKey:item.key];
                total--;
                suc = YES;
            } else {
                break;
            }
            if (!suc) break;
        }
    } while (total > maxCount && items.count > 0 && suc);
    return suc;
}

-(BOOL)removeItemsEarlierThanTime:(int)age
{
    if (time <= 0) return YES;
    if (time == INT_MAX) {
        [self removeAllItems];
        return YES;
    }
    NSArray *arr = [_manager getKeysEarlierThan:age];
    if (arr.count > 0) {
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *key = (NSString *)obj;
            [_kv removeValueForKey:key];
        }];
    }
    return YES;
}

-(int64_t)getDiskFreeSpace
{
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error){
        return -1;
    }
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0){
        space = -1;
    }
    return space;
}

-(void)removeAllItems
{
    [_kv clearAll];
    [_manager removeAllData];
}

@end
