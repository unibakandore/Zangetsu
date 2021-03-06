/*
//  CWDictionaryTests.m
//  Zangetsu
//
//  Created by Colin Wheeler on 11/26/10.
//  Copyright 2010. All rights reserved.
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

#import <Zangetsu/Zangetsu.h>
#import "CWDictionaryTests.h"

@implementation CWDictionaryTests

/**
 Test for cw_dictionaryContainsKey to make sure it works properly. In this
 case it should return true for finding the object in the dictionary.
 */
-(void)testContainsKey
{
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo",@"bar",nil];
	
	STAssertTrue([dictionary cw_dictionaryContainsKey:@"bar"],@"Dictionary should contain key bar");
}

-(void)testDictionaryMapping
{
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo",@"bar",nil];
	
	NSDictionary *d2 = [dictionary cw_mapDictionary:^(id *key,id *value) {
		//*value = @"morvo"; //for testing...
	}];
	
	STAssertTrue([dictionary isEqualToDictionary:d2],@"Dictionary and Dictionary2 should be equal");
}

-(void)testEach {
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Futurama",
								@"McCloud",@"Highlander", nil];
	
	__block NSMutableDictionary *dictionary2 = [[NSMutableDictionary alloc] init];
	
	[dictionary cw_each:^(id key, id value) {
		[dictionary2 setValue:value forKey:key];
	}];
	
	STAssertTrue([dictionary isEqualToDictionary:dictionary2], @"Dictionaries should be the same");
}

-(void)testEachConcurrent {
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Fry",@"Futurama",
								@"McCloud",@"Highlander", nil];
	
	__block NSMutableDictionary *dictionary2 = [[NSMutableDictionary alloc] init];
	
	[dictionary cw_eachConcurrentlyWithBlock:^(id key, id value, BOOL *stop) {
		[dictionary2 setValue:value forKey:key];
	}];
	
	STAssertTrue([dictionary isEqualToDictionary:dictionary2], @"Dictionaries should be the same");
}

@end
