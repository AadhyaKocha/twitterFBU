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
@property (weak, nonatomic) IBOutlet UILabel *characterLabel;

@end

@implementation composeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composeText.delegate = self;
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    int characterLimit = 140;
    NSString *newText = [self.composeText.text stringByReplacingCharactersInRange:range withString:text];
    unsigned long charactersLeft = characterLimit - newText.length;
    //NSLog(@"Character count is: %lu", newText.length);
    self.characterLabel.text = [NSString stringWithFormat:@"%lu", charactersLeft];
    
    return newText.length < characterLimit;
}


@end
