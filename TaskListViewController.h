//
//  TaskListViewController.h
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h";

@interface TaskListViewController : UITableViewController {

	NSMutableArray *tasks;
	
}

@property (nonatomic, retain) NSMutableArray *tasks;

- (void) showDetailView:(Task *)task addingToList:(BOOL)adding;
- (NSString *) tasksPath;
- (void) loadTasks;
- (void) saveTasks;

@end
