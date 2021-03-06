//
//  NewUserViewController.m
//  Student Q
//
//  Created by Eric Mentele on 4/1/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "NewUserViewController.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

#define studentQURL @"https://studentq.firebaseio.com"

@interface NewUserViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation NewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firebase                          = [[Firebase alloc] initWithUrl:studentQURL];
    //[self.firebase setValue:nil];
    
}


#pragma mark Keyboard handling
- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOn:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOff:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardOn:(NSNotification*)notification {
    
    UIBarButtonItem *doneButton            = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(keyboardOff:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}


- (void)keyboardOff:(NSNotificationCenter*)notification {
    
    [self.view endEditing:YES];
    self.navigationItem.rightBarButtonItem = false;
}


- (IBAction)addUser:(id)sender {
    Firebase *newUserRef                   = self.firebase;
    [newUserRef createUser:self.emailTextField.text password:self.passwordTextField.text withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        
        if (error) {
            DDLogError(@"%@", error);
        } else {
            NSLog(@"Successfully created user account!");
            [[NSUserDefaults standardUserDefaults] setObject:self.emailTextField.text forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        //DDLogInfo(@"email %@", email);
        // add profile info for the newly created user
        Firebase *users                        = [self.firebase childByAppendingPath:@"users"];
        Firebase *user                         = [users childByAutoId];
        NSDictionary *profile                  = @{
                                                   @"userID"         : result[@"uid"],
                                                   @"fullName"       : self.nameTextField.text,
                                                   @"profilePicture" : @"some path to picture"
                                                   };
        [user setValue:profile];
    }];
    
    NSString *email                        = [[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *password                     = [[NSUserDefaults standardUserDefaults]stringForKey:@"password"];
    
    [self.firebase authUser:email password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
        
        if (authData == nil) {
            
        }
        else if (error) {
            DDLogError(@"%@", error);
            
        } else {
            DDLogInfo(@"Logged in!");
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
