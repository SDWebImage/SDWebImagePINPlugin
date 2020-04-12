/*
 * This file is part of the SDWebImage package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <PINCache/PINCache.h>
#import <SDWebImage/SDWebImage.h>

/// PINMemoryCache category to support `SDMemoryCache` protocol. This allow user who prefer PINMemoryCache to be used as SDWebImage's custom memory cache
@interface PINMemoryCache (SDAdditions) <SDMemoryCache>

@end
