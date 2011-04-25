//
//  CWGraphicsFoundation.m
//  Zangetsu
//
//  Created by Colin Wheeler on 12/24/10.
//  Copyright 2010. All rights reserved.
//

#import "CWGraphicsFoundation.h"

/**
 Easy way to return the CGContextRef inside a NSView
 */
inline CGContextRef CWCurrentCGContext()
{
	return (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
}

void CWAddRoundedRectToPath(CGContextRef context,
						  CGRect rect,
						  float ovalWidth,
						  float ovalHeight)
{
    float fw, fh;
	
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
	
    CGContextSaveGState(context);
	
    CGContextTranslateCTM (context, CGRectGetMinX(rect),CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
	
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
	
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
	
    CGContextRestoreGState(context);
}
