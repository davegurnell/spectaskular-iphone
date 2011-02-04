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

- (NSString *) tasksPath;

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


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveTasks];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
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
