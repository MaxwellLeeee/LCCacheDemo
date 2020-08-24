//
//  LCDiskCacheManager.h
//  LCCacheDemo
//
//  Created by 李畅 on 2020/8/23.
//  Copyright © 2020 李畅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCDiskCacheManager : NSObject

@property NSUInteger countLimit;
@property NSUInteger sizeLimit;
@property NSTimeInterval ageLimit;
@property NSUInteger freeDiskSpaceLimit;
@property NSTimeInterval autoTrimInterval;

+(instancetype)sharedInstance;

- (BOOL)setObject:(nullable NSObject<NSCoding> *)object forKey:(NSString *)key;

- (BOOL)setBool:(BOOL)value forKey:(NSString *)key;

- (BOOL)setInt32:(int32_t)value forKey:(NSString *)key;

- (BOOL)setUInt32:(uint32_t)value forKey:(NSString *)key;

- (BOOL)setInt64:(int64_t)value forKey:(NSString *)key;

- (BOOL)setUInt64:(uint64_t)value forKey:(NSString *)key;

- (BOOL)setFloat:(float)value forKey:(NSString *)key;

- (BOOL)setDouble:(double)value forKey:(NSString *)key;

- (BOOL)setString:(NSString *)value forKey:(NSString *)key;

- (BOOL)setDate:(NSDate *)value forKey:(NSString *)key;

- (BOOL)setData:(NSData *)value forKey:(NSString *)key;

- (nullable id)getObjectOfClass:(Class)cls forKey:(NSString *)key;

- (BOOL)getBoolForKey:(NSString *)key;
- (BOOL)getBoolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (int32_t)getInt32ForKey:(NSString *)key;
- (int32_t)getInt32ForKey:(NSString *)key defaultValue:(int32_t)defaultValue;

- (uint32_t)getUInt32ForKey:(NSString *)key;
- (uint32_t)getUInt32ForKey:(NSString *)key defaultValue:(uint32_t)defaultValue;

- (int64_t)getInt64ForKey:(NSString *)key;
- (int64_t)getInt64ForKey:(NSString *)key defaultValue:(int64_t)defaultValue;

- (uint64_t)getUInt64ForKey:(NSString *)key;
- (uint64_t)getUInt64ForKey:(NSString *)key defaultValue:(uint64_t)defaultValue;

- (float)getFloatForKey:(NSString *)key;
- (float)getFloatForKey:(NSString *)key defaultValue:(float)defaultValue;

- (double)getDoubleForKey:(NSString *)key;
- (double)getDoubleForKey:(NSString *)key defaultValue:(double)defaultValue;

- (nullable NSString *)getStringForKey:(NSString *)key;
- (nullable NSString *)getStringForKey:(NSString *)key defaultValue:(nullable NSString *)defaultValue;

- (nullable NSDate *)getDateForKey:(NSString *)key;
- (nullable NSDate *)getDateForKey:(NSString *)key defaultValue:(nullable NSDate *)defaultValue;

- (nullable NSData *)getDataForKey:(NSString *)key;
- (nullable NSData *)getDataForKey:(NSString *)key defaultValue:(nullable NSData *)defaultValue;

@end

NS_ASSUME_NONNULL_END
