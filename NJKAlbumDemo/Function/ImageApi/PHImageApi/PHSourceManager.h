//
//  PHSourceManager.h
//  RJPhotoGallery
//
//  Created by Rylan Jin on 9/25/15.
//  Copyright © 2015 Rylan Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PHSourceManager : NSObject

//@property (nonatomic, strong) PHCachingImageManager *manager;

+ (BOOL)haveAccessToPhotos;

//- (void)getMomentsWithAscending:(BOOL)ascending
//                     completion:(void (^)(BOOL ret, id obj))completion;

//- (void)getImageForPHAsset:(PHAsset *)asset
//                  withSize:(CGSize)size
//                completion:(void (^)(BOOL ret, UIImage *image))completion;

//- (void)getURLForPHAsset:(PHAsset *)asset
//              completion:(void (^)(BOOL ret, NSURL *URL))completion;

+ (void)getAlbumsWithCompletion:(void (^)(BOOL ret, NSMutableArray *resultArray))completion;

+ (void)getPosterImageForAsset:(PHAsset *)asset
                    completion:(void (^)(BOOL ret, UIImage *image))completion;

//- (void)getPhotosWithGroup:(id)group
//                completion:(void (^)(BOOL ret, id obj))completion;

@end
