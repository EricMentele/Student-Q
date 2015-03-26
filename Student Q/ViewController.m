//
//  ViewController.m
//  Student Q
//
//  Created by Eric Mentele on 3/17/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "ViewController.h"

#define studentQURL @"https://studentq.firebaseio.com"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.firebase = [[Firebase alloc] initWithUrl:studentQURL];
    // Create a reference to a Firebase location
    
    [_firebase setValue:@"Do you have data? You'll love Firebase."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
