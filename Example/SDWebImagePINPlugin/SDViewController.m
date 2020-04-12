/*
* This file is part of the SDWebImagePINPlugin package.
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

#import "SDViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImagePINPlugin/SDWebImagePINPlugin.h>
#import <PINCache/PINCache.h>

@interface SDViewController ()

@property (nonatomic, strong) SDAnimatedImageView *imageView;

@end

@implementation SDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Setup YYCache to default cache
    SDWebImageManager.defaultImageCache = [[PINCache alloc] initWithName:@"PINCache"];
    
    [self.view addSubview:self.imageView];
    [SDWebImageManager.sharedManager.imageCache clearWithCacheType:SDImageCacheTypeAll completion:nil];
    SDWebImageManager.sharedManager.cacheSerializer = [SDWebImageCacheSerializer cacheSerializerWithBlock:^NSData * _Nullable(UIImage * _Nonnull image, NSData * _Nullable data, NSURL * _Nullable imageURL) {
        image.sd_extendedObject = @"Extended Data Here";
        return data;
    }];
    
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif"];
    [self.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSString *extentedObject = (NSString *)image.sd_extendedObject;
        NSLog(@"%@", extentedObject);
    }];
}

- (SDAnimatedImageView *)imageView {
    if (!_imageView) {
        _imageView = [[SDAnimatedImageView alloc] initWithFrame:self.view.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _imageView;
}

@end
