//
//  PhotoItem.m
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import "PhotoItem.h"

@implementation PhotoItem

-(instancetype)initWithURL:(NSString *)urlString{
    
    self = [super init];
    if (self){
        _imageURL = [NSURL URLWithString:urlString];
    }
    return self;
}

@end
