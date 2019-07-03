//
//  composeViewController.m
//  twitter
//
//  Created by aadhya on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "composeViewController.h"
#import "APIManager.h"

@interface composeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *publishTweet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closePublishing;
//UITextviewdelegate

@end

@implementation composeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.composeText.delegate = self;
}
- (IBAction)closeButtonAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)publishButtonAction:(id)sender {
    [[APIManager shared]postStatusWithText:self.composeText.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
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
