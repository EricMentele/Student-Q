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
    self.firebase         = [[Firebase alloc] initWithUrl:studentQURL];
    [self.firebase setValue:nil];
    NSString *UUID = [[NSUUID UUID] UUIDString];
    NSString *email = [NSString stringWithFormat:@"eric.mentele.%@@icloud.com", UUID];
    [self.firebase createUser:email password:@"password"
     withValueCompletionBlock:^(NSError *error, NSDictionary *authUser) {
         // check to see if account was created ok
         if (error) {
             DDLogError(@"%@", error);
         } else {
             NSLog(@"Successfully created user account with uid: %@", authUser[@"uid"]);
         }
         DDLogInfo(@"email %@", email);
         // add profile info for the newly created user
        Firebase *users       = [self.firebase childByAppendingPath:@"users"];
        Firebase *user        = [users childByAutoId];
        NSDictionary *profile = @{
            @"userID"         : authUser[@"uid"],
            @"fullName"       : [NSString stringWithFormat:@"Eric Mentele %@", UUID],
            @"profilePicture" : @"some path to picture"
         };
         [user setValue:profile];

         // add class to be reused by any user
         Firebase *classes     = [self.firebase childByAppendingPath:@"classes"];
         Firebase *class       = [classes childByAutoId];
         NSDictionary *classInfo   = @{
             @"className"  : @"iOS Fundamentals",
             @"location" : @"",
             @"classOwnerID" : authUser[@"uid"],
             @"taCode" : @"5678",
             @"studentCode": @"5642",
             @"helpQueue": @{
            }
        };
         [class setValue:classInfo];
         
         // add user created above as teacher of the newly created class
         Firebase *userClasses = [user childByAppendingPath:@"classes"];
         Firebase *userClass   = [userClasses childByAppendingPath:class.key];
         NSDictionary *userClassInfo = @{
                                         @"classRole": @"Teacher",
                                         @"presence": @(1)
                                         };
         [userClass setValue:userClassInfo];
         
         // add second user
         // queue second user for help in class
    }];

}

#pragma mark Add Student To Queue Methods



- (IBAction)addUser:(id)sender {

   }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
