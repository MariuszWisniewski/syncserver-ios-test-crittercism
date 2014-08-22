//
//  SYNViewController.m
//  syncserver-ios-test
//
//  Created by Mariusz Wisniewski on 14/08/14.
//  Copyright (c) 2014 Mariusz Wisniewski. All rights reserved.
//

#import "SYNViewController.h"

#import <Syncano.h>
#import <SyncanoSyncServer.h>

#import <Crittercism.h>

@interface SYNViewController () <SyncanoSyncServerDelegate>

@property (strong, nonatomic) SyncanoSyncServer *syncServer;
@property (strong, nonatomic) Syncano *syncano;
@property (strong, nonatomic) UILabel *label;

@end

@implementation SYNViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.syncServer = [SyncanoSyncServer syncanoSyncServerForDomain:@"YOUR-DOMAIN" apiKey:@"YOUR-API-KEY"];
	self.syncServer.delegate = self;
	NSError *error = nil;
	[self.syncServer connect:&error];
  
	self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.bounds), 50)];
	self.label.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.label];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	NSString *breadcrumb = [NSString stringWithFormat:@"View controller appeared on screen: %@", [self class]];
	[Crittercism leaveBreadcrumb:breadcrumb];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSString *breadcrumb = [NSString stringWithFormat:@"Will show view controller through segue: %@", [[segue destinationViewController] class]];
	[Crittercism leaveBreadcrumb:breadcrumb];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)syncServerConnectionOpened:(SyncanoSyncServer *)syncServer {
	NSLog(@"Sync Server Connection opened");
	SyncanoParameters_Subscriptions_SubscribeCollection *params = [[SyncanoParameters_Subscriptions_SubscribeCollection alloc] initWithProjectId:@"YOUR-PROJECT-ID" collectionId:@"YOUR-COLLECTION-ID" context:@"connection"];
	[self.syncServer sendRequest:params callback: ^(SyncanoResponse *response) {
    NSLog(@"Subscription response: %@", response);
	}];
}

- (void)syncServer:(SyncanoSyncServer *)syncServer connectionClosedWithError:(NSError *)error {
	NSLog(@"Sync Server Error: %@", error);
}

- (void)syncServer:(SyncanoSyncServer *)syncServer notificationAdded:(SyncanoData *)addedData {
	NSLog(@"Added data: %@", addedData);
	dispatch_async(dispatch_get_main_queue(), ^{
    self.label.text = addedData.title;
	});
}

@end
