#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import <SDWebImagePINPlugin/PINCache+SDAdditions.h>
#import <SDWebImagePINPlugin/PINMemoryCache+SDAdditions.h>
#import <SDWebImagePINPlugin/PINDiskCache+SDAdditions.h>

FOUNDATION_EXPORT double SDWebImagePINPluginVersionNumber;
FOUNDATION_EXPORT const unsigned char SDWebImagePINPluginVersionString[];

