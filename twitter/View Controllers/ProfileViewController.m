//
//  ProfileViewController.m
//  twitter
//
//  Created by aadhya on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *AuthorName;
@property (weak, nonatomic) IBOutlet UILabel *ScreenName;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *NumberOfTweets;
@property (weak, nonatomic) IBOutlet UILabel *NumberOfFollowing;
@property (weak, nonatomic) IBOutlet UILabel *NumberOfFollowers;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
