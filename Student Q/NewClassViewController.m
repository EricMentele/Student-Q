//
//  NewClassViewController.m
//  Student Q
//
//  Created by Eric Mentele on 4/16/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "NewClassViewController.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

#define studentQURL @"https://studentq.firebaseio.com"

@interface NewClassViewController ()

@property (weak, nonatomic) IBOutlet UITextField *classNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentPassTextField;
@property (weak, nonatomic) IBOutlet UITextField *tAPassTextField;

@end

@implementation NewClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firebase = [[Firebase alloc]initWithUrl:studentQURL];
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
    
    self.navigationItem.rightBarButtonItem = false;
    [self.view endEditing:YES];
}


- (IBAction)newClassButton:(id)sender {
    
    Firebase *classes = [self.firebase childByAppendingPath:@"classes"];
    Firebase *class = [classes childByAutoId];
    
    NSDictionary *classInfo     = @{
                                    @"className"  : self.classNameTextField.text,
                                    @"location" : @"Some Location",
                                    @"classOwnerID" : @"userid",
                                    @"taCode" : self.tAPassTextField.text,
                                    @"studentCode": self.studentPassTextField.text,
                                    @"helpQueue" : @{
                                            
                                            
                                            }
                                    };
    [class setValue:classInfo];
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
