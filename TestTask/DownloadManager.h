//
//  DownloadManager.h
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONParser.h"

@class PhotoItem;

@interface DownloadManager : NSObject

+ (instancetype)sharedInstance;
- (void)searchImages:(NSString *)searchKey completion:(void(^)(NSArray<PhotoItem *> *photos, NSError *error))completion;

@end
