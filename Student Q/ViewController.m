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

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController 

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.firebase = [[Firebase alloc] initWithUrl:studentQURL];
    //[_firebase setValue:@"Do you have data? You'll love Firebase."];//firebase test

    self.tableView.dataSource = self;
    
}

#pragma mark Add Student To Queue Methods

- (IBAction)addStudent:(id)sender {
    
}

#pragma mark Table View methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell"];
    cell.textLabel.text = @"Test";
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
