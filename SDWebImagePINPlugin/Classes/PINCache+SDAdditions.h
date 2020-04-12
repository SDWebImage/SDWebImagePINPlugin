/*
 * This file is part of the SDWebImage package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */


#import <PINCache/PINCache.h>
#import <SDWebImage/SDWebImage.h>

/// PINCache category to support `SDImageCache` protocol. This allow user who prefer PINCache to be used as SDWebImage's custom image cache
@interface PINCache (SDAdditions) <SDImageCache>

@end
