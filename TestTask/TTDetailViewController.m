//
//  TTDetailViewController.m
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import "TTDetailViewController.h"

@interface TTDetailViewController ()

@end

@implementation TTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = image;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
