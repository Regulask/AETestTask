//
//  TTMainViewController.h
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *TypedTextField;
- (IBAction)SearchButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;
- (IBAction)segmentControlTapped:(UISegmentedControl*)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
