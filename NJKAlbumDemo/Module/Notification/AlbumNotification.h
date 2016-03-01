//
//  AlbumNotification.h
//  NJKAlbumDemo
//
//  Created by JiakaiNong on 16/3/1.
//  Copyright © 2016年 poco. All rights reserved.
//

#ifndef AlbumNotification_h
#define AlbumNotification_h

#define ALBUM_DID_PICK_IMAGE_NOTIFICATION @"albumDidPickImageNotification"

@protocol AlbumNotificationPoster <NSObject>

@required
- (void)postNotificationWithObject:(id)object;

@end

@protocol AlbumNotificationReciever <NSObject>

@required
- (void)addNotification;
- (void)removeNotification;

@end

#endif /* AlbumNotification_h */
