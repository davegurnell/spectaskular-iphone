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

@interface TaskDetailViewController( Private )

- (NSMutableArray *)tasks;
- (void)leaveView;

@end

@implementation TaskDetailViewController

@synthesize nameField;
@synthesize task;
@synthesize addingToList;

- (id) initWithTask:(Task *)initialTask addingToList:(BOOL)adding {
	self = [super init];
	if(self) {
		self.task = initialTask;
		self.addingToList = adding;
		self.navigationItem.title = task.name;
	}
	return self;
}

- (NSMutableArray *)tasks {
	SpectaskularAppDelegate *delegate = [UIApplication sharedApplication].delegate;
	return delegate.tasks;
}

- (void) viewDidLoad {
	self.navigationItem.leftBarButtonItem =
		[[[UIBarButtonItem alloc] initWithTitle:@"Cancel"
										  style:UIBarButtonItemStylePlain
										 target:self
										 action:@selector(cancelPressed)] autorelease];
	
	self.navigationItem.rightBarButtonItem =
		[[[UIBarButtonItem alloc] initWithTitle:@"Done"
										  style:UIBarButtonItemStylePlain
										 target:self
										 action:@selector(donePressed)] autorelease];
}

- (void) viewWillAppear:(BOOL)animated {
	self.nameField.text = self.task.name;
	[self.nameField becomeFirstResponder];
	[super viewWillAppear:animated];
}

- (void) dealloc {
	self.task = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Actions

- (void) donePressed {
	self.task.name = self.nameField.text;

	NSLog(@"Done task %@", task);

	if(self.addingToList) {
		[[self tasks] insertObject:self.task atIndex:0];
	}

	[self leaveView];
}

- (void)cancelPressed {
	[self leaveView];
}

- (void)leaveView {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
