/*
//  CWSimpleCoreData.h
//
//  Created by Colin Wheeler on 9/20/09.
//  Copyright 2009 Colin Wheeler. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <Cocoa/Cocoa.h>


@interface CWSimpleCoreData : NSObject

/* returns all entities matching the entity name and
 * (if applicable) the predicate given 
 */
+(NSArray *)allEntitiesForName:(NSString *)entityName 
		inManagedObjectContext:(NSManagedObjectContext *)moc 
				 withPredicate:(NSPredicate *)predicate 
			andSortDescriptors:(NSArray *)descriptors
					  andError:(NSError **)error;

/* returns the object count for all entities matching
 * the given entity name
 */
+(NSUInteger)objectCountForEntity:(NSString *)entityName
		   inManagedObjectContext:(NSManagedObjectContext *)moc
						withError:(NSError **)error;

/* creates a new NSManagedObject with the entity given
 * and optionally a nsmanagedobjectcontext
 */
+(NSManagedObject *)newObjectWithEntityName:(NSString *)entityName 
					 inManagedObjectContext:(NSManagedObjectContext *)moc 
								  andValues:(NSDictionary *)values;

+(NSArray *)fetchEntitiesWithName:(NSString *)entityName 
		   inManagedObjectContext:(NSManagedObjectContext *)moc 
					withPredicate:(NSPredicate *)predicate
					   properties:(NSArray *)properties 
			   andSortDescriptors:(NSArray *)descriptors 
							error:(NSError **)error;

@end
