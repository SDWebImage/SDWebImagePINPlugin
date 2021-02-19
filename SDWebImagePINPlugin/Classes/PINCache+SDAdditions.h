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

/// PINCache category to support `SDImageCache` protocol. This allow user who prefer PINCache to be used as SDWebImage's custom image cache
@interface PINCache (SDAdditions) <SDImageCache>

@end
