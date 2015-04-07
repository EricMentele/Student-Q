//
//  MyClassesViewController.m
//  Student Q
//
//  Created by Eric Mentele on 4/6/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "MyClassesViewController.h"
#import "NewUserViewController.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

#define studentQURL @"https://studentq.firebaseio.com"

@interface MyClassesViewController ()

@property (nonatomic, strong) FAuthData *currentUser;
@end

@implementation MyClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firebase                    = [[Firebase alloc] initWithUrl:studentQURL];
    
    NSString *email                  = [[NSUserDefaults standardUserDefaults]stringForKey:@"email"];
    NSString *password               = [[NSUserDefaults standardUserDefaults]stringForKey:@"password"];
    
    [self.firebase authUser:email password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
        
        if (authData == nil) {
            
            [self performSegueWithIdentifier:@"newUser" sender:self];

        }
        else if (error) {
             DDLogError(@"%@", error);
            
        } else {
            DDLogInfo(@"Logged in!");
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
