//
//  DownloadManager.m
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import "DownloadManager.h"

static NSString *const kKey = @"80bfbd87ab15ec86dca6854950d6d1db";

@implementation DownloadManager

+(instancetype)sharedInstance{
    
    static DownloadManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[super alloc] init];
    });
    
    return manager;
}

- (void)searchImages:(NSString *)searchKey completion:(void(^)(NSArray<PhotoItem *> *photos, NSError *error))completion{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&format=json&nojsoncallback=1&extras=url_m", kKey, searchKey]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (json)
            {
                JSONParser *parser = [JSONParser new];
                NSArray *photos = [parser parseWithResponse:json];
                
                if (completion)
                {
                    completion(photos, error);
                }
            }
        }
    }];
    
    [dataTask resume];
}

@end
