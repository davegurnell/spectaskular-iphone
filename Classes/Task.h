//
//  Task.h
//  Spectaskular
//
//  Created by Dave Gurnell on 02/02/2011.
//  Copyright 2011 Untyped. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject {
	NSString *name;
}

@property (nonatomic, retain) NSString *name;

- (id) initWithName:(NSString *)initialName;
- (id) initWithTask:(Task *)other;

@end
