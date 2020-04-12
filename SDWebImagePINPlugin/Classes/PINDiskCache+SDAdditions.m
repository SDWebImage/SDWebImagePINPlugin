/*
 * This file is part of the SDWebImage package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "PINDiskCache+SDAdditions.h"
#import <objc/runtime.h>

@interface SDFileAttributeHelper : NSObject

// Internal Classes

+ (nullable NSArray<NSString *> *)extendedAttributeNamesAtPath:(nonnull NSString *)path traverseLink:(BOOL)follow error:(NSError * _Nullable * _Nullable)err;
+ (BOOL)hasExtendedAttribute:(nonnull NSString *)name atPath:(nonnull NSString *)path traverseLink:(BOOL)follow error:(NSError * _Nullable * _Nullable)err;
+ (nullable NSData *)extendedAttribute:(nonnull NSString *)name atPath:(nonnull NSString *)path traverseLink:(BOOL)follow error:(NSError * _Nullable * _Nullable)err;
+ (BOOL)setExtendedAttribute:(nonnull NSString *)name value:(nonnull NSData *)value atPath:(nonnull NSString *)path traverseLink:(BOOL)follow overwrite:(BOOL)overwrite error:(NSError * _Nullable * _Nullable)err;
+ (BOOL)removeExtendedAttribute:(nonnull NSString *)name atPath:(nonnull NSString *)path traverseLink:(BOOL)follow error:(NSError * _Nullable * _Nullable)err;

@end

@interface PINDiskCache ()

@property (nonatomic, strong, nullable) SDImageCacheConfig *sd_config;

// Internal Headers
- (NSURL *)encodedFileURLForKey:(NSString *)key;

@end

@implementation PINDiskCache (SDAdditions)

- (SDImageCacheConfig *)sd_config {
    return objc_getAssociatedObject(self, @selector(sd_config));
}

- (void)setSd_config:(SDImageCacheConfig *)sd_config {
    objc_setAssociatedObject(self, @selector(sd_config), sd_config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - SDDiskCache

- (instancetype)initWithCachePath:(NSString *)cachePath config:(SDImageCacheConfig *)config {
    NSString *name = cachePath.lastPathComponent; // Use last path component for naming
    self = [self initWithName:name rootPath:cachePath];
    if (self) {
        self.sd_config = config;
    }
    return self;
}

- (BOOL)containsDataForKey:(NSString *)key {
    return [self containsObjectForKey:key];
}

- (NSData *)dataForKey:(NSString *)key {
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSData class]]) {
        return (NSData *)object;
    } else {
        return nil;
    }
}

- (void)setData:(NSData *)data forKey:(NSString *)key {
    if (!data) {
        return; // PINDiskCache will remove object if `data` is nil
    }
    
    [self setObject:data forKey:key];
}

- (NSData *)extendedDataForKey:(NSString *)key {
    // get cache Path for image key
    NSString *cachePathForKey = [self cachePathForKey:key];
    
    NSData *extendedData = [SDFileAttributeHelper extendedAttribute:PINDiskCachePrefix atPath:cachePathForKey traverseLink:NO error:nil];
    
    return extendedData;
}

- (void)setExtendedData:(NSData *)extendedData forKey:(NSString *)key {
    NSParameterAssert(key);
    // get cache Path for image key
    NSString *cachePathForKey = [self cachePathForKey:key];
    
    if (!extendedData) {
        // Remove
        [SDFileAttributeHelper removeExtendedAttribute:PINDiskCachePrefix atPath:cachePathForKey traverseLink:NO error:nil];
    } else {
        // Override
        [SDFileAttributeHelper setExtendedAttribute:PINDiskCachePrefix value:extendedData atPath:cachePathForKey traverseLink:NO overwrite:YES error:nil];
    }
}

- (void)removeDataForKey:(NSString *)key {
    [self removeObjectForKey:key];
}

- (void)removeAllData {
    [self removeAllObjects];
}

- (void)removeExpiredData {
    NSTimeInterval ageLimit = self.sd_config.maxDiskAge;
    NSDate *dateLimit = [NSDate dateWithTimeIntervalSinceNow:ageLimit];
    NSUInteger sizeLimit = self.sd_config.maxDiskSize;
    
    [self trimToSize:sizeLimit];
    [self trimToDate:dateLimit];
}

- (NSString *)cachePathForKey:(NSString *)key {
    NSURL *cacheURL = [self fileURLForKey:key];
    return cacheURL.path;
}

- (NSUInteger)totalCount { 
    NSUInteger count = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:self.cacheURL.path];
    count = fileEnumerator.allObjects.count;
    return count;
}


- (NSUInteger)totalSize {
    return self.byteCount;
}


@end
