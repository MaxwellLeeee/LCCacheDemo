//
//  ViewController.m
//  LCCacheDemo
//
//  Created by 李畅 on 2020/8/23.
//  Copyright © 2020 李畅. All rights reserved.
//

#import "ViewController.h"
#import "YYKit.h"
#import "LCLRUManager.h"
#import "LCShowAnimationController.h"
#import "LCCircleListViewController.h"
#import "LCDiskCacheManager.h"

#define kLoopCpunt (100000)
#define kLimitCpunt (1000)


#define kSizeLimit (1030 * 1024 * 1024)
#define kFullSize (kLoopCpunt / 2.0)

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@property (nonatomic, strong) LCLRUManager *circleLinkListManager;
@property (nonatomic, strong) YYMemoryCache *yyManager;
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) LCDiskCacheManager *diskCache;
@property (nonatomic, strong) YYDiskCache *yyDiskCache;
@property (nonatomic, strong) NSString *testString;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cache Example";
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"YYKit test" class:@""];
    [self addCell:@"LCLRUManager test" class:@""];
    [self addCell:@"NSCache test" class:@""];
    [self addCell:@"LCDiskCache test" class:@""];
    [self addCell:@"YYDiskCache test" class:@""];
    [self addCell:@"Demo display" class:@""];
    [self.view addSubview:self.tableView];
    
    //[self log];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tableView setFrame:self.view.bounds];
}

- (void)log {
    printf("all:%.2f MB   used:%.2f MB   free:%.2f MB   active:%.2f MB  inactive:%.2f MB  wird:%.2f MB  purgable:%.2f MB\n",
           [UIDevice currentDevice].memoryTotal / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryUsed / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryFree / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryActive / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryInactive / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryWired / 1024.0 / 1024.0,
           [UIDevice currentDevice].memoryPurgable / 1024.0 / 1024.0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self log];
    });
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self testYYLinkListMap];
    }else if(indexPath.row == 1){
        [self testCircleLinkList];
//        [self testCircleLinkListWithCount:1000];
//        [self testCircleLinkListWithLimitMBSize:10];
    }else if (indexPath.row == 2){
//        [self testNSCacheWithCount:1000];
        [self testNSCacheWithLimitMBSize:10];
    }else if(indexPath.row == 3){
        [self testDiskCacheWithCountLimit:100];
    }else if(indexPath.row == 4){
        [self testYYDiskCahce];
    }else{
//        LCShowAnimationController *ctr = [LCShowAnimationController new];
        LCCircleListViewController *ctr = [LCCircleListViewController new];
        ctr.hidesBottomBarWhenPushed = YES;
        if (self.navigationController) {
            [self.navigationController pushViewController:ctr animated:YES];
        }else{
            [self presentViewController:ctr animated:YES completion:nil];
        }
    }
    return;
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark YYMemoryCache

-(void)testYYLinkListMap
{
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    NSString *data = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    NSUInteger singleCost = kSizeLimit / kFullSize;
    for (int i = 0; i < kLoopCpunt; i ++) {
        NSString *key = @(i).stringValue;
        [self.yyManager setObject:data forKey:key withCost:singleCost];
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
//    NSLog(@"YYLinkListMap count limnit = %lld cost = %f", _yyManager.countLimit, (end - start));
    NSLog(@"YYLinkListMap size limnit = %d MB singleSize = %ld cost = %f", kSizeLimit / 1024 / 1024, singleCost, (end - start));
}

#pragma mark LCLRUManager

-(void)testCircleLinkList
{
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    NSString *data = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    for (int i = 0; i < kLoopCpunt; i ++) {
        NSString *key = @(i).stringValue;
        [self.circleLinkListManager setObject:data forKey:key cost:1024 * 10];
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"CircleLinkList cost = %f", (end - start));
}

#pragma mark LCLRUManager 限制数量

-(void)testCircleLinkListWithCount:(NSInteger)count
{
    LCLRUManager *manager = [[LCLRUManager alloc] init];
    manager.countLimit = count;
    manager.autoTrimInterval = 5;
    
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    NSString *data = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    for (int i = 0; i < kLoopCpunt; i ++) {
        NSString *key = @(i).stringValue;
        [manager setObject:data forKey:key cost:data.length * 2];
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"CircleLinkList count = %ld cost = %f", (long)count, (end - start));
    
    [manager removeAllObjects];
    if (count < 100000) {
        [self testCircleLinkListWithCount:(count + 1000)];
    }
}

#pragma mark LCLRUManager 限制大小

-(void)testCircleLinkListWithLimitMBSize:(NSInteger)count
{
    LCLRUManager *manager = [[LCLRUManager alloc] init];
    manager.sizeLimit = count * 1024 * 1024;
    manager.autoTrimInterval = 5;
    
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    NSString *data = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    NSUInteger singleCost = count * 1024 * 1024 / kFullSize;
    for (int i = 0; i < kLoopCpunt; i ++) {
        NSString *key = @(i).stringValue;
        [manager setObject:data forKey:key cost:singleCost];
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"CircleLinkList size limnit = %ld MB singleSize = %ld cost = %f", (long)count, singleCost, (end - start));
    
    [manager removeAllObjects];
    if (count < 1040) {
        [self testCircleLinkListWithLimitMBSize:(count + 10)];
    }
}

#pragma mark NSCache

-(void)testNSCache
{
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    NSString *data = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    for (int i = 0; i < kLoopCpunt; i ++) {
        NSString *key = @(i).stringValue;
        [self.cache setObject:data forKey:key cost:data.length * 2];
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"NSCache cost = %f", (end - start));
}

#pragma mark NSCache 限制数量

-(void)testNSCacheWithCount:(NSInteger)count
{
    NSCache *cache = [[NSCache alloc] init];
    cache.countLimit = count;
    
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    NSString *data = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    for (int i = 0; i < kLoopCpunt; i ++) {
        NSString *key = @(i).stringValue;
        [cache setObject:data forKey:key cost:data.length * 2];
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"NSCache count =%ld  cost = %f", (long)count, (end - start));
    [cache removeAllObjects];
    if (count < 100000) {
        [self testNSCacheWithCount:(count + 1000)];
    }
}

#pragma mark NSCache 限制大小

-(void)testNSCacheWithLimitMBSize:(NSInteger)count
{
    NSCache *cache = [[NSCache alloc] init];
    cache.totalCostLimit = count * 1024 * 1024;;
    
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    NSString *data = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    NSUInteger singleCost = count * 1024 * 1024 / kFullSize;
    for (int i = 0; i < kLoopCpunt; i ++) {
        NSString *key = @(i).stringValue;
        [cache setObject:data forKey:key cost:singleCost];
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"NSCache size limnit = %ld MB singleSize = %ld cost = %f", (long)count, singleCost, (end - start));
    [cache removeAllObjects];
    if (count < 1040) {
        [self testNSCacheWithLimitMBSize:(count + 10)];
    }
}

#pragma mark - disk cache limit count

-(void)testDiskCacheWithCountLimit:(NSInteger)count
{
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    for (int i = 0; i < 100; i ++) {
        [self.diskCache setString:self.testString forKey:@(i).stringValue];        
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"disk Cache size cost = %f", (end - start));
}

#pragma mark - YYDisk cache limit count

-(void)testYYDiskCahce
{
    NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    for (int i = 0; i < 10000; i ++) {
        [self.yyDiskCache setObject:self.testString forKey:@(i).stringValue];
    }
    NSTimeInterval end = [[NSDate date] timeIntervalSince1970];
    NSLog(@"YY disk Cache size cost = %f", (end - start));
}

#pragma mark - getters

-(LCLRUManager *)circleLinkListManager
{
    if (!_circleLinkListManager) {
        _circleLinkListManager = [[LCLRUManager alloc] init];
        _circleLinkListManager.sizeLimit = 10 * 1024 * 1024;
        _circleLinkListManager.autoTrimInterval = 5;
    }
    return _circleLinkListManager;
}

-(YYMemoryCache *)yyManager
{
    if (!_yyManager) {
        _yyManager = [[YYMemoryCache alloc] init];
        _yyManager.costLimit = kSizeLimit;
        _yyManager.autoTrimInterval = 5;
        _yyManager.releaseOnMainThread = YES;
    }
    return _yyManager;
}

-(NSCache *)cache
{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = 800;
        _cache.totalCostLimit = 10 * 1024 * 1024;
    }
    return _cache;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(LCDiskCacheManager *)diskCache
{
    if (!_diskCache) {
        _diskCache = [[LCDiskCacheManager alloc] init];
        _diskCache.countLimit = 50;
    }
    return _diskCache;
}

-(NSString *)testString
{
    if (!_testString) {
        _testString = @"iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    }
    return _testString;
}

-(YYDiskCache *)yyDiskCache
{
    if (!_yyDiskCache) {
        NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        _yyDiskCache = [[YYDiskCache alloc] initWithPath:dataPath];
        _yyDiskCache.countLimit = 50;
    }
    return _yyDiskCache;
}
@end
