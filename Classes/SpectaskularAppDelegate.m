//
//  SpectaskularAppDelegate.m
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import "SpectaskularAppDelegate.h"
#import "TaskListViewController.h"

@interface SpectaskularAppDelegate( Private )

- (NSString *)tasksPath;

@end

@implementation SpectaskularAppDelegate

@synthesize window;
@synthesize navController;
@synthesize tasks;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	[self loadTasks];

    [self.window addSubview:navController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveTasks];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc {
    [window release];
	[navController release];
	[tasks release];
    [super dealloc];
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
