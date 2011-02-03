//
//  TaskDetailViewController.m
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import "SpectaskularAppDelegate.h"
#import "TaskListViewController.h"
#import "TaskDetailViewController.h"
#import "Task.h"

@implementation TaskDetailViewController

@synthesize nameField;
@synthesize task;
@synthesize addingToList;

- (TaskDetailViewController *)initWithTask:(Task *)initialTask addingToList:(BOOL)adding {
	[super init];
	self.task = initialTask;
	self.addingToList = adding;
	self.navigationItem.title = task.name;
	
	return self;
}

- (void)viewDidLoad {
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
																	 style:UIBarButtonItemStylePlain
																	target:self action:@selector(cancelPressed)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
																   style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(donePressed)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
}

- (void)viewWillAppear:(BOOL)animated {
	self.nameField.text = self.task.name;
	
	Task* edited = [[Task alloc] initWithTask:self.task];
	[edited release];
	
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	NSArray *stack = [[self navigationController] viewControllers];
	NSInteger parentIndex = [stack count] - 1;
	TaskListViewController *parent = [stack objectAtIndex:parentIndex];
	[parent.tableView reloadData];
	
	[super viewWillDisappear:animated];
}
	 
- (void)viewDidUnload {
	self.task = nil;
    [super viewDidUnload];
}

- (void)dealloc {
	[self.task release];
    [super dealloc];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

#pragma mark -
#pragma mark Actions

- (void)donePressed {
	self.task.name = self.nameField.text;

	if(self.addingToList) {
		NSArray *stack = [[self navigationController] viewControllers];
		NSInteger parentIndex = [stack count] - 2;
		TaskListViewController *parent = [stack objectAtIndex:parentIndex];
		[parent.tasks insertObject:task atIndex:0];
	}
	
	[self leaveView];
}

- (void)cancelPressed {
	[self leaveView];
}

- (void)leaveView {
	SpectaskularAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navController popViewControllerAnimated:YES];
}

@end
