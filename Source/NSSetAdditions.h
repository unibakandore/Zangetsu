//
//  NSSetAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 11/15/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSSet (CWNSSetAdditions) 

-(NSSet *)cw_each:(void (^)(id obj))block;

-(id)cw_findWithBlock:(BOOL (^)(id obj))block;

-(NSArray *)cw_findAllWithBlock:(BOOL (^)(id obj))block;

-(NSHashTable *)cw_findAllIntoWeakRefsWithBlock:(BOOL (^)(id))block;

-(NSSet *)cw_mapSet:(id (^)(id obj))block;

@end