//
//  TaskListViewController.m
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import "TaskListViewController.h"
#import "TaskDetailViewController.h"

@implementation TaskListViewController

@synthesize tasks;

- (void)viewDidLoad {
	[self loadTasks];
		
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

	[editButton release];	
	[super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

- (void)viewDidUnload {
	self.tasks = nil;
	[super viewDidUnload];
}

- (void)dealloc {
	[self.tasks release];
	[super dealloc];
}

#pragma mark -
#pragma mark Table view controller

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tasks count];
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
	
	NSLog(@"Rendering row %d", row);
	NSLog(@"Rendering task %@", task);
	NSLog(@"Rendering cell %@", cell);
	
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
	
	NSLog(@"Swapping %d %d", sourceRow, destinationRow);
	
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

#pragma mark -
#pragma mark Persistence

- (NSString *)tasksPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *dir = [paths objectAtIndex:0];
	NSString *path = [dir stringByAppendingPathComponent:@"tasks.plist"];
	return path;
}

- (void)loadTasks {
	NSString *path = [self tasksPath];
	NSArray *data = nil;
	if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		data = [[NSMutableArray alloc] initWithContentsOfFile:path];
	} else {
		data = [[NSMutableArray alloc] initWithObjects: @"Buy coffee", @"Feed cat", @"Write awesome software", nil]; 
	}
	
	NSInteger countTasks = [data count];
	NSMutableArray *loadedTasks = [[NSMutableArray alloc] init];
	
	for(int i = 0; i < countTasks; i++) {
		Task *task = [[Task alloc] initWithName:[data objectAtIndex:i]];
		[loadedTasks addObject:task];
		[task release];
	}
	
	self.tasks = loadedTasks;

	[loadedTasks release];
	[data release];
}

- (void)saveTasks {
	NSString *path = [self tasksPath];
	NSMutableArray *data = [[NSMutableArray alloc] init];

	NSInteger countTasks = [self.tasks count];
	for(int i = 0; i < countTasks; i++) {
		Task *task = [self.tasks objectAtIndex:i];
		[data addObject:task.name];
	}
	
	// BOOL success = 
	[data writeToFile:path atomically:YES];
	[data release];
}

@end
