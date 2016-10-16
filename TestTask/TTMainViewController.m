//
//  TTMainViewController.m
//  TestTask
//
//  Created by Kasim Asyukov on 16/10/2016.
//  Copyright © 2016 Kasim Asyukov. All rights reserved.
//

#import "TTMainViewController.h"
#import "PhotoItem.h"
#import "TTCollectionViewCell.h"
#import "TTDetailViewController.h"
#import "DownloadManager.h"
#import "Reachability.h"

static NSString * const reuseIdentifier = @"PhotoCell";

@interface TTMainViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) NSArray<PhotoItem *> *photos;
@property (nonatomic, assign) int displayColumns;
@property (nonatomic) Reachability *hostReachability;

@end

@implementation TTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayColumns =1;
    
    //Reachability
    NSString *remoteHostName = @"www.apple.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
}


- (IBAction)segmentControlTapped:(UISegmentedControl*)sender {
    
    if (sender.selectedSegmentIndex==0) {
        self.displayColumns = 1;
    }
    if (sender.selectedSegmentIndex==1) {
        self.displayColumns = 2;
    }
    if (sender.selectedSegmentIndex==2) {
        self.displayColumns = 3;
    }
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SearchButtonPressed:(id)sender {
    
    [self.TypedTextField resignFirstResponder];
    if (self.TypedTextField.text.length>0 ) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [[DownloadManager sharedInstance] searchImages:self.TypedTextField.text completion:^(NSArray <PhotoItem*> *photos, NSError *error){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error && photos.count > 0){
                    
                    self.photos = photos;
                    [self.collectionView reloadData];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                }
            });
        }];
    }
    else{
        //Alert here
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message"
                                                                                 message:@"Please type any word in text field"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PhotoItem *photo = self.photos[indexPath.row];
    NSData *imageData = [NSData dataWithContentsOfURL:photo.imageURL];
    cell.photoImageView.image = [UIImage imageWithData:imageData];

    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return YES;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfColumns = self.displayColumns;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    CGFloat totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * (numberOfColumns - 1));
    CGFloat width = (collectionView.bounds.size.width - totalSpace) / (CGFloat)numberOfColumns;
    
    CGSize size = CGSizeMake(width, width);
    
    return size;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        PhotoItem *item = self.photos[indexPath.row];
        
        TTDetailViewController *detailViewController = (TTDetailViewController *)segue.destinationViewController;
        detailViewController.imageURL = item.imageURL;
    }
    
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        switch (netStatus) {
            case NotReachable:
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot load data" message:@"Please check internet connection."
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                               }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
                break;
            }
            case ReachableViaWWAN:
            {
                break;
            }
            case ReachableViaWiFi:
            {
                break;
            }
                
            default:
                break;
        }
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
