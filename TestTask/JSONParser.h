//
//  JSONParser.h
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoItem;

@interface JSONParser : NSObject

-(NSArray <PhotoItem*> *)parseWithResponse:(NSDictionary *)dict;

@end
