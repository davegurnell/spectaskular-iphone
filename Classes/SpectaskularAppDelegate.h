//
//  SpectaskularAppDelegate.h
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpectaskularAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;
	UINavigationController *navController;
	NSMutableArray *tasks;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) NSMutableArray *tasks;

- (void)loadTasks;
- (void)saveTasks;

@end

