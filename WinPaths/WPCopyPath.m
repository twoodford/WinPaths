//
//  WPCopyPath.m
//  WinPaths
//
//  Created by Timothy on 5/27/14.
//  Copyright (c) 2014 Timothy Woodford. All rights reserved.
//

#import "WPCopyPath.h"

@implementation WPCopyPath
+ (void) copyPath: (NSURL *)inurl
{
    NSLog(@"inurl=%@", [inurl filePathURL]);
    NSString *normalized = [[[inurl filePathURL] path] substringFromIndex:8];
    NSLog(@"stage2=%@", normalized);
    NSString *winpath = [@"\\" stringByAppendingString:[normalized stringByReplacingOccurrencesOfString:@"/" withString:@"\\"]];
    NSLog(@"winpath=%@", winpath);
    [[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
    [[NSPasteboard generalPasteboard] setString:winpath forType:NSPasteboardTypeString];
}
@end
