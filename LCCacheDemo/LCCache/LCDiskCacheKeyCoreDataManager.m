//
//  LCDiskCacheKeyCoreDataManager.m
//  LCCacheDemo
//
//  Created by 李畅 on 2020/8/24.
//  Copyright © 2020 李畅. All rights reserved.
//

#import "LCDiskCacheKeyCoreDataManager.h"
#import <CoreData/CoreData.h>
#import <time.h>

@interface LCDiskCacheKeyCoreDataManager()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSPersistentContainer *persistentContainer;

@end


@implementation LCDiskCacheKeyCoreDataManager


-(NSManagedObjectContext *)context
{
    if (!_context) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"CacheDemo" withExtension:@"momd"];
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        dataPath = [NSString stringWithFormat:@"%@/diskcacheKey.sqlite", dataPath];
        [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL URLWithString:dataPath] options:nil error:nil];
        _context.persistentStoreCoordinator = coordinator;
    }
    return _context;
}

-(NSPersistentContainer *)persistentContainer
{
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CacheDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull storeDescription, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}

-(DiskCacheKey *)insertKey:(NSString *)key
{
    NSError *error = nil;
    DiskCacheKey *object = (DiskCacheKey *)[NSEntityDescription insertNewObjectForEntityForName:@"DiskCacheKey" inManagedObjectContext:self.context];
    object.key = key;
    object.updateTime = (int64_t)time(NULL);
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
        return nil;
    }else{
        NSLog(@"插入数据成功 key : %@", key);
    }
    return object;
}

//https://www.jianshu.com/p/d9ee92cd3483
-(void)deleteKey:(NSString *)key
{
    
}

-(void)updateTimeInKey:(NSString *)key
{
    
}

-(NSArray *)getKeysWithCount:(NSInteger)count
{
    return nil;
}

@end
