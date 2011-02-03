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

- (id) init {
	return [self initWithName:@""];
}

- (id) initWithName:(NSString *)initialName {
	self = [super init];
	if(self) {
		self.name = initialName;
	}
	return self;
}

- (id) initWithTask:(Task *)other {
	self = [super init];
	if(self) {
		self.name = other.name;
	}
	return self;
}

- (void) dealloc {
	self.name = nil;
	[super dealloc];
}

- (NSString *) description {
	return [NSString stringWithFormat:@"<Task: %@>", self.name];
}

@end
