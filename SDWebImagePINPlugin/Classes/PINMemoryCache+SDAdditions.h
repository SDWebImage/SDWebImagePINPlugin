/*
 * This file is part of the SDWebImagePINPlugin package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#if __has_include(<PINCache/PINCache.h>)
#import <PINCache/PINCache.h>
#else
@import PINCache;
#endif
#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
@import SDWebImage;
#endif

/// PINMemoryCache category to support `SDMemoryCache` protocol. This allow user who prefer PINMemoryCache to be used as SDWebImage's custom memory cache
@interface PINMemoryCache (SDAdditions) <SDMemoryCache>

@end
