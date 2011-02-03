//
//  Task.m
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize name;

- (Task *) init {
	[super init];
	self.name = @"New task";
	return self;
}

- (Task *) initWithName:(NSString *)initialName {
	[super init];
	self.name = initialName;
	return self;
}

- (Task *) initWithTask:(Task *)other {
	[super init];
	self.name = other.name;
	return self;
}

@end
