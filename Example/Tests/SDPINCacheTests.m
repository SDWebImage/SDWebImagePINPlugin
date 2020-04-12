/*
 * This file is part of the SDWebImagePINPlugin package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDTestCase.h"

static NSString *kTestImageKeyJPEG = @"TestImageKey.jpg";
static NSString *kTestImageKeyPNG = @"TestImageKey.png";

@interface SDPINCacheTests : SDTestCase

@property (nonatomic, class, readonly) PINCache *sharedCache;

@end

@implementation SDPINCacheTests

+ (PINCache *)sharedCache {
    static dispatch_once_t onceToken;
    static PINCache *cache;
    dispatch_once(&onceToken, ^{
        cache = [[PINCache alloc] initWithName:@"default"];
    });
    return cache;
}

#pragma mark - PINMemoryCache & PINDiskCache
- (void)testCustomMemoryCache {
    SDImageCacheConfig *config = [[SDImageCacheConfig alloc] init];
    config.memoryCacheClass = [PINMemoryCache class];
    NSString *nameSpace = @"PINMemoryCache";
    NSString *cacheDictionary = [self makeDiskCachePath:nameSpace];
    SDImageCache *cache = [[SDImageCache alloc] initWithNamespace:nameSpace diskCacheDirectory:cacheDictionary config:config];
    id memoryCache = cache.memoryCache;
    expect([memoryCache isKindOfClass:[PINMemoryCache class]]).to.beTruthy();
}

- (void)testCustomDiskCache {
    SDImageCacheConfig *config = [[SDImageCacheConfig alloc] init];
    config.diskCacheClass = [PINDiskCache class];
    NSString *nameSpace = @"PINDiskCache";
    NSString *cacheDictionary = [self makeDiskCachePath:nameSpace];
    SDImageCache *cache = [[SDImageCache alloc] initWithNamespace:nameSpace diskCacheDirectory:cacheDictionary config:config];
    id diskCache = cache.diskCache;
    expect([diskCache isKindOfClass:[PINDiskCache class]]).to.beTruthy();
}

#pragma mark - PINCache

- (void)testCustomImageCache {
    SDWebImageManager *manager = [[SDWebImageManager alloc] initWithCache:SDPINCacheTests.sharedCache loader:SDWebImageDownloader.sharedDownloader];
    expect(manager.imageCache).to.equal(SDPINCacheTests.sharedCache);
}

- (void)testPINCacheQueryOp {
    XCTestExpectation *expectation = [self expectationWithDescription:@"SDImageCache query op works"];
    NSData *imageData = [NSData dataWithContentsOfFile:[self testJPEGPath]];
    [SDPINCacheTests.sharedCache.diskCache setData:imageData forKey:kTestImageKeyJPEG];
    [SDPINCacheTests.sharedCache queryImageForKey:kTestImageKeyJPEG options:0 context:nil completion:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
        expect(image).notTo.beNil();
        [expectation fulfill];
    }];
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPINCacheStoreOp {
    XCTestExpectation *expectation = [self expectationWithDescription:@"SDImageCache store op works"];
    [SDPINCacheTests.sharedCache storeImage:[self testJPEGImage] imageData:nil forKey:kTestImageKeyJPEG cacheType:SDImageCacheTypeAll completion:^{
        UIImage *memoryImage = [SDPINCacheTests.sharedCache.memoryCache objectForKey:kTestImageKeyJPEG];
        expect(memoryImage).notTo.beNil();
        NSData *diskData = (NSData *)[SDPINCacheTests.sharedCache.diskCache objectForKey:kTestImageKeyJPEG];
        expect(diskData).notTo.beNil();
        [expectation fulfill];
    }];
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPINCacheRemoveOp {
    XCTestExpectation *expectation = [self expectationWithDescription:@"SDImageCache remove op works"];
    [SDPINCacheTests.sharedCache removeImageForKey:kTestImageKeyJPEG cacheType:SDImageCacheTypeDisk completion:^{
        UIImage *memoryImage = [SDPINCacheTests.sharedCache.memoryCache objectForKey:kTestImageKeyJPEG];
        expect(memoryImage).notTo.beNil();
        NSData *diskData = (NSData *)[SDPINCacheTests.sharedCache.diskCache objectForKey:kTestImageKeyJPEG];
        expect(diskData).to.beNil();
        [expectation fulfill];
    }];
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPINCacheContainsOp {
    XCTestExpectation *expectation = [self expectationWithDescription:@"SDImageCache contains op works"];
    [SDPINCacheTests.sharedCache setObject:[self testPNGImage] forKey:kTestImageKeyPNG];
    [SDPINCacheTests.sharedCache containsImageForKey:kTestImageKeyPNG cacheType:SDImageCacheTypeAll completion:^(SDImageCacheType containsCacheType) {
        expect(containsCacheType).equal(SDImageCacheTypeMemory);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testPINCacheClearOp {
    XCTestExpectation *expectation = [self expectationWithDescription:@"SDImageCache clear op works"];
    [SDPINCacheTests.sharedCache clearWithCacheType:SDImageCacheTypeAll completion:^{
        UIImage *memoryImage = [SDPINCacheTests.sharedCache.memoryCache objectForKey:kTestImageKeyJPEG];
        expect(memoryImage).to.beNil();
        NSData *diskData = (NSData *)[SDPINCacheTests.sharedCache.diskCache objectForKey:kTestImageKeyJPEG];
        expect(diskData).to.beNil();
        [expectation fulfill];
    }];
    [self waitForExpectationsWithCommonTimeout];
}

#pragma mark Helper methods

- (UIImage *)testJPEGImage {
    static UIImage *reusableImage = nil;
    if (!reusableImage) {
        reusableImage = [[UIImage alloc] initWithContentsOfFile:[self testJPEGPath]];
    }
    return reusableImage;
}

- (UIImage *)testPNGImage {
    static UIImage *reusableImage = nil;
    if (!reusableImage) {
        reusableImage = [[UIImage alloc] initWithContentsOfFile:[self testPNGPath]];
    }
    return reusableImage;
}

- (NSString *)testJPEGPath {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    return [testBundle pathForResource:@"TestImage" ofType:@"jpg"];
}

- (NSString *)testPNGPath {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    return [testBundle pathForResource:@"TestImage" ofType:@"png"];
}

- (nullable NSString *)makeDiskCachePath:(nonnull NSString*)fullNamespace {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}

@end
