//
//  JSONParser.m
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import "JSONParser.h"
#import "PhotoItem.h"

@implementation JSONParser

-(NSArray<PhotoItem *> *)parseWithResponse:(NSDictionary *)dict{
    
    NSArray *photosInfo = dict[@"photos"][@"photo"];
    
    NSMutableArray *parsedPhotots = [NSMutableArray new];
    
    for (NSDictionary *photoInfo in photosInfo)
    {
        NSString *urlString = photoInfo[@"url_m"];
        PhotoItem *photo = [[PhotoItem alloc] initWithURL:urlString];
        [parsedPhotots addObject:photo];
    }
    return [parsedPhotots copy];
}

@end
