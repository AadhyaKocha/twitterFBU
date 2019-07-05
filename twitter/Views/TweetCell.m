//
//  TweetCell.m
//  twitter
//
//  Created by aadhya on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImage addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImage setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate tweetCell:self didTap:self.tweet.user];
}

@end
