//
//  ViewController.h
//  Student Q
//
//  Created by Eric Mentele on 3/17/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ViewController : UIViewController <UITableViewDataSource>

@property (nonatomic,strong) Firebase *firebase;
@end

