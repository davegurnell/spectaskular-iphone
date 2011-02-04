//
//  TaskListViewController.m
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import "SpectaskularAppDelegate.h"
#import "TaskListViewController.h"
#import "TaskDetailViewController.h"

@interface TaskListViewController( Private )

- (NSMutableArray *)tasks;

@end


@implementation TaskListViewController

- (NSMutableArray *)tasks {
	SpectaskularAppDelegate *delegate = [UIApplication sharedApplication].delegate;
	return delegate.tasks;
}

- (void)viewDidLoad {
	self.navigationItem.leftBarButtonItem =
		[[[UIBarButtonItem alloc] initWithTitle:@"Add"
										  style:UIBarButtonItemStylePlain
										 target:self
										 action:@selector(addPressed)] autorelease];
	
	self.navigationItem.rightBarButtonItem =
		[[[UIBarButtonItem alloc] initWithTitle:@"Edit"
										  style:UIBarButtonItemStylePlain
										 target:self
										 action:@selector(editPressed)] autorelease];

	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
	[super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view controller

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self tasks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *TaskCellIdentifier = @"TaskCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TaskCellIdentifier];
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:TaskCellIdentifier] autorelease];
	}

	cell.showsReorderControl = YES;

	NSUInteger row = [indexPath row];
	Task *task = [self.tasks objectAtIndex:row];
	
	cell.textLabel.text = task.name;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Task *task = [self.tasks objectAtIndex:[indexPath row]];
	[self showDetailView:task addingToList:NO];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		[self.tasks removeObjectAtIndex:[indexPath row]];
		[self.tableView reloadData];
	}
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	NSInteger sourceRow = [sourceIndexPath row];
	NSInteger destinationRow = [destinationIndexPath row];
	
	if(sourceRow != destinationRow) {
		Task *sourceTask = [[self.tasks objectAtIndex:sourceRow] retain];
		Task *destinationTask = [[self.tasks objectAtIndex:destinationRow] retain];

		[self.tasks replaceObjectAtIndex:destinationRow withObject:sourceTask];
		[self.tasks replaceObjectAtIndex:sourceRow withObject:destinationTask];
		
		[sourceTask release];
		[destinationTask release];
	}
}

#pragma mark -
#pragma mark Add/edit button actions

- (void)addPressed {
	Task *task = [[Task alloc] init];
	[self showDetailView:task addingToList:YES];
	[task release];
}

- (void)editPressed {
	[self setEditing:![self isEditing] animated:YES];
	if([self isEditing]) {
		[self.navigationItem.rightBarButtonItem setTitle:@"Done"];
	} else {
		[self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
	}
}

- (void)showDetailView: (Task *)task addingToList:(BOOL)adding {
	TaskDetailViewController *detail = [[TaskDetailViewController alloc] initWithTask:task addingToList:adding];
	[self.navigationController pushViewController:detail animated:YES];
	[detail release];
}

@end
