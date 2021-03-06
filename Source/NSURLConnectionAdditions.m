/*
//  NSURLConnectionAdditions.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/6/10.
//  Copyright 2010 . All rights reserved.
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

#import "NSURLConnectionAdditions.h"


@implementation NSURLConnection (CWNSURLConnectionAdditions)

/**
 Checks the Queue and request parameters then dispatches a block onto
 the passed in queue, executes a synchronous request and then dispatches
 a block back onto the main thread and executes the block passed in
 */
+(void)cw_performAsynchronousRequest:(NSURLRequest *)request 
						  onGCDQueue:(dispatch_queue_t)queue 
					 completionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block
{
	NSParameterAssert(request);
	NSParameterAssert(queue);
	
	dispatch_async(queue, ^{
		
		NSURLResponse *_response = nil;
		NSError *_urlError;
		
		NSData *_data = [NSURLConnection sendSynchronousRequest:request
											  returningResponse:&_response 
														  error:&_urlError];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			block(_data,_response,_urlError);
		});
	});
}

/**
 Checks the passed in NSURLRequest and then uses dispatch_sync to 
 perform the syncrhonous request. In general this is used only in 
 some specific cercumstances otherwise this could potentially
 block the main thread (if you are executing this method on there.)
 */
+(NSData *)cw_performGCDSynchronousRequest:(NSURLRequest *)request 
								  response:(NSURLResponse **)response 
								  andError:(NSError **)error
{
	NSParameterAssert(request);
	
	__block NSData *data = nil;
	__block NSURLResponse *resp = nil;
	__block NSError *err;
	
	dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		data = [NSURLConnection sendSynchronousRequest:request 
									 returningResponse:&resp 
												 error:&err];
	});
	
	*response = resp;
	*error = err;
	
	return data;
}

@end
