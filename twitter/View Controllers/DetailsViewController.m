//
//  DetailsViewController.m
//  twitter
//
//  Created by aadhya on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *Username;
@property (weak, nonatomic) IBOutlet UILabel *ScreenName;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *DatePosted;

@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;

@property (weak, nonatomic) IBOutlet UILabel *retweeted;
@property (weak, nonatomic) IBOutlet UILabel *favorited;
@property (weak, nonatomic) IBOutlet UILabel *replied;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Username.text = self.tweet.user.name;
    self.ScreenName.text = self.tweet.user.screenName;
    self.DatePosted.text = self.tweet.createdAtString;
    self.caption.text = self.tweet.text;
    self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.favoriteCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.replyCount.text = [NSString stringWithFormat:@"%i", self.tweet.replyCount];
    
    NSString *profileURLString = self.tweet.user.profileImage;
    NSURL *profileURL = [NSURL URLWithString:profileURLString];
    
    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:profileURL];
    
    if (self.tweet.favorited == YES) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    else if (self.tweet.favorited == NO) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted == YES) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    else if (self.tweet.retweeted == NO) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapFavorite:(id)sender {
    
    if (self.tweet.favorited == NO) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [self refreshData];
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    else if (self.tweet.favorited == YES) {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [self refreshData];
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == NO) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self refreshData];
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState: UIControlStateNormal];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else if (self.tweet.retweeted == YES) {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [self refreshData];
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState: UIControlStateNormal];
        
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unRetweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unRetweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (IBAction)didTapReply:(id)sender {
    if (self.tweet.replied == NO) {
        self.tweet.replied = YES;
        self.tweet.replyCount += 1;
        [self refreshData];
    }
    else if (self.tweet.replied == YES) {
        self.tweet.replied = NO;
        self.tweet.replyCount -= 1;
        [self refreshData];
    }
}

- (void)refreshData {
    self.favoriteCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.retweeted.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.replied.text = [NSString stringWithFormat:@"%i", self.tweet.replyCount];
}

@end
