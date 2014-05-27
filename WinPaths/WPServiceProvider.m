//
//  WPServiceProvider.m
//  WinPaths
//
//  Created by Timothy on 5/27/14.
//  Copyright (c) 2014 Timothy Woodford. All rights reserved.
//

#import "WPServiceProvider.h"

#import "WPOpenLink.h"

@implementation WPServiceProvider
- (void)openLinkService:(NSPasteboard *)pboard userData:(NSString *)userData error:(NSString **)error
{
    // Boilerplate service code
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    if (![pboard canReadObjectForClasses:classes options:[NSDictionary dictionary]]) {
        *error = @"Couldn't get path string from the pasteboard";
        return;
    }
    NSString *pboardString = [pboard stringForType:NSPasteboardTypeString];
    [WPOpenLink openLink:pboardString error:error];
}
@end
