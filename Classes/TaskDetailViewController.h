//
//  TaskDetailViewController.h
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TaskDetailViewController : UIViewController {
	UITextField *nameField;

	Task *task;
	Task *editedTask;
	
	BOOL addingToList;
}

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) Task *task;
@property BOOL addingToList;

- (TaskDetailViewController *)initWithTask:(Task *)initialTask addingToList:(BOOL)adding;

- (void)donePressed;
- (void)cancelPressed;
- (void)leaveView;

@end
