//
//  AppDelegate.m
//  WinPaths
//
//  Created by Timothy on 5/27/14.
//  Copyright (c) 2014 Timothy Woodford. All rights reserved.
//

#import "AppDelegate.h"

#import "WPServiceProvider.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    WPServiceProvider *prov = [[WPServiceProvider alloc] init];
    [NSApp setServicesProvider:prov];
}

@end
