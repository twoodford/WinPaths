//
//  WPOpenLink.m
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

#import "WPOpenLink.h"

#import <NetFS/NetFS.h>

@implementation WPOpenLink
+(void) openLink: (NSString *) link error:(NSString **) error
{
    NSString *slashed = [link stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"smb:%@", slashed]];
    NSLog(@"slashed=%@", url);
    NSArray *path = [url pathComponents];
    //DBG NSLog(@"pathComponents=%@", path);
    
    // Open SMB share
    NSString *basefolder = [path firstObject];
    if ([basefolder isEqualTo:@"/"]) {
        basefolder = [path objectAtIndex:1];
    }
    NSURL *shareUrl = [NSURL URLWithString:[NSString stringWithFormat:@"smb://%@/%@", [url host], basefolder]];
    NSLog(@"Mounting SMB share using URL \"%@\"", shareUrl);
    
    
    CFArrayRef mountpoints = CFArrayCreate(NULL, NULL, NULL, NULL);
    int merr = NetFSMountURLSync(CFBridgingRetain(shareUrl), NULL, NULL, NULL, NULL, NULL, &mountpoints);
    if (merr != 0) {
        *error = @"Could not mount SMB volume";
    }
    CFStringRef basepath = (CFStringRef) CFArrayGetValueAtIndex(mountpoints, 0);
    // basepath is the location that the fs was mounted to, should be used as as the basepath eventually, but more work will be needed
    
    
    // Open the file itself
    NSURL *fileUrl = [[NSURL URLWithString:[NSString stringWithFormat: @"file:///Volumes/%@", [path componentsJoinedByString:@"/"]]] absoluteURL];
    NSLog(@"Opening target file using URL \"%@\"", fileUrl);
    [[NSWorkspace sharedWorkspace] openURL:fileUrl];
}
@end
