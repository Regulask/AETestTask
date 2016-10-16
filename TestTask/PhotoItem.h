//
//  PhotoItem.h
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoItem : NSObject

@property (nonatomic, strong, readonly) NSURL *imageURL;

-(instancetype)initWithURL:(NSString *)urlString;

@end
