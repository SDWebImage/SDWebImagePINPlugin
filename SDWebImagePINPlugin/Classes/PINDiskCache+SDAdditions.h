/*
 * This file is part of the SDWebImage package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <PINCache/PINCache.h>
#import <SDWebImage/SDWebImage.h>

/// PINDiskCache category to support `SDDiskCache` protocol. This allow user who prefer PINDiskCache to be used as SDWebImage's custom disk cache
@interface PINDiskCache (SDAdditions) <SDDiskCache>

@end
