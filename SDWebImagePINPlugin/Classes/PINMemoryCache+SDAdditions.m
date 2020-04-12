/*
 * This file is part of the SDWebImage package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "PINMemoryCache+SDAdditions.h"
#import <objc/runtime.h>

@interface PINMemoryCache ()

@property (nonatomic, strong, nullable) SDImageCacheConfig *sd_config;

@end

@implementation PINMemoryCache (SDAdditions)

- (SDImageCacheConfig *)sd_config {
    return objc_getAssociatedObject(self, @selector(sd_config));
}

- (void)setSd_config:(SDImageCacheConfig *)sd_config {
    objc_setAssociatedObject(self, @selector(sd_config), sd_config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - SDMemoryCache

- (instancetype)initWithConfig:(SDImageCacheConfig *)config {
    self = [self init];
    if (self) {
        self.sd_config = config;
        self.costLimit = config.maxMemoryCost;
    }
    return self;
}

- (void)setObject:(id)object forKey:(id)key cost:(NSUInteger)cost {
    [self setObject:object forKey:key withCost:cost];
}

@end
