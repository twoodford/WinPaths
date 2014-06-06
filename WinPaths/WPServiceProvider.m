//
//  WPServiceProvider.m
//  WinPaths
//
//  Created by Timothy on 5/27/14.
//  Copyright (c) 2014 Timothy Woodford.
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//        http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

#import "WPServiceProvider.h"

#import "WPOpenLink.h"
#import "WPCopyPath.h"

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
    [[NSApplication sharedApplication] terminate:self];
}

- (void)copyPathService:(NSPasteboard *)pboard userData:(NSString *)userData error:(NSString **)error
{
    // Boilerplate service code
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    if (![pboard canReadObjectForClasses:classes options:[NSDictionary dictionary]]) {
        *error = @"Couldn't get path string from the pasteboard";
        return;
    }
    NSURL *inurl = [[pboard readObjectsForClasses:[NSArray arrayWithObject:[NSURL class]] options:[NSDictionary dictionary]] objectAtIndex:0];
    [WPCopyPath copyPath:inurl];
    [[NSApplication sharedApplication] terminate:self];
}
@end
