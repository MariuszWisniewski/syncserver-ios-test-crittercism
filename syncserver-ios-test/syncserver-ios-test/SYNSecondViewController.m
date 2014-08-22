//
//  SYNSecondViewController.m
//  syncserver-ios-test
//
//  Created by Mariusz Wisniewski on 21/08/14.
//  Copyright (c) 2014 Mariusz Wisniewski. All rights reserved.
//

#import "SYNSecondViewController.h"

#import <Crittercism.h>

@interface SYNSecondViewController ()

@end

@implementation SYNSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)crashTheApp {
  [NSException raise:NSGenericException format:@"We're raising a test exception"];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Change background color of the view, to cleary see when it appears
  self.view.backgroundColor = [UIColor lightGrayColor];
  
  //Create crash button and set its properties
  UIButton *crashButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [crashButton setTranslatesAutoresizingMaskIntoConstraints:NO];
  [crashButton setTitle:@"CRASH!!!" forState:UIControlStateNormal];
  [crashButton addTarget:self action:@selector(crashTheApp) forControlEvents:UIControlEventTouchUpInside];
  crashButton.titleLabel.textAlignment = NSTextAlignmentCenter;
  [crashButton sizeToFit];
  //Add button to our view
  [self.view addSubview:crashButton];
  //Center button in its superview
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:crashButton
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.0]];
  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:crashButton
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:0.0]];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  NSString *breadcrumb = [NSString stringWithFormat:@"View controller appeared on screen: %@",[self class]];
  [Crittercism leaveBreadcrumb:breadcrumb];
}

#pragma mark - Navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSString *breadcrumb = [NSString stringWithFormat:@"Will show view controller through segue: %@",[[segue destinationViewController] class]];
  [Crittercism leaveBreadcrumb:breadcrumb];
}

@end
