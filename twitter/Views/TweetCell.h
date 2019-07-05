//
//  TweetCell.h
//  twitter
//
//  Created by aadhya on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetCell.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TweetCellDelegate;

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDate;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) Tweet *tweet;

@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;

@property (weak, nonatomic) IBOutlet UILabel *retweeted;
@property (weak, nonatomic) IBOutlet UILabel *favorited;
@property (weak, nonatomic) IBOutlet UILabel *replied;

@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@property (nonatomic, weak) id<TweetCellDelegate> delegate;

@end

@protocol TweetCellDelegate
- (void)tweetCell:(TweetCell *) tweetCell didTap: (User *)user;
@end

NS_ASSUME_NONNULL_END
