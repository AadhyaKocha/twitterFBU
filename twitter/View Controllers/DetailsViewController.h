//
//  DetailsViewController.h
//  twitter
//
//  Created by aadhya on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Tweet* tweet;

@end

NS_ASSUME_NONNULL_END
