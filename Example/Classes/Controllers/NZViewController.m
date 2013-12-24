//
//  NZViewController.m
//  NSString-Email
//
//  Created by Bruno Tortato Furtado on 24/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "NZViewController.h"
#import "NSString+Email.h"

@interface NZViewController ()

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UILabel *lbMessage;

- (IBAction)refresh:(id)sender;
- (IBAction)confirmClicked;
- (IBAction)viewClicked;

- (void)showErrorMessage:(NSString *)message;
- (void)showSuccessfulMessage:(NSString *)message;

@end



@implementation NZViewController

#pragma mark -
#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refresh:nil];
}

#pragma mark -
#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange intersection = NSIntersectionRange(NSMakeRange(0, 1), range);
    
    if (intersection.length > 0) {
        [self refresh:nil];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self refresh:nil];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self confirmClicked];
    return YES;
}

#pragma mark -
#pragma mark - Actions

- (IBAction)refresh:(id)sender
{
    self.lbMessage.text = nil;
    self.txtEmail.text = nil;
}

- (IBAction)confirmClicked
{
    NSString *message = @"Valid email";
    
    if ([self.txtEmail.text length] == 0) {
        message = @"Required field";
        [self showErrorMessage:message];
        return;
    }
    
    if (![self.txtEmail.text isEmail]) {
        message = @"Invalid email";
        [self showErrorMessage:message];
        return;
    }
    
    [self showSuccessfulMessage:message];
}

- (IBAction)viewClicked
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark - Private methods

- (void)showErrorMessage:(NSString *)message
{
    self.lbMessage.textColor = [UIColor redColor];
    self.lbMessage.text = message;
}

- (void)showSuccessfulMessage:(NSString *)message
{
    self.lbMessage.textColor = [UIColor colorWithRed:0.001 green:0.536 blue:0.002 alpha:1.000];
    self.lbMessage.text = message;
}

@end
