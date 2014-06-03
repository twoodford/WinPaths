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
    
    
    CFArrayRef mountpoints = CFArrayCreate(NULL, NULL, 0, NULL);
    int merr = NetFSMountURLSync(CFBridgingRetain(shareUrl), NULL, NULL, NULL, NULL, NULL, &mountpoints);
    if (merr != 0) {
        *error = @"Could not mount SMB volume";
    }
    
    // Open the file itself
    NSString *basepath;
    // Check if we actually mounted anything new
    if (CFArrayGetCount(mountpoints) > 0) {
        // basepath is the location that the fs was mounted to
        basepath = (NSString *) CFArrayGetValueAtIndex(mountpoints, 0);
    } else {
        // If we didn't, we check every mounted volume to find where it was mounted previously
        NSArray *mounted = [[NSFileManager defaultManager] mountedVolumeURLsIncludingResourceValuesForKeys:[NSArray arrayWithObject:NSURLVolumeURLForRemountingKey] options:0];
        NSURL *rsrcUrl;
        NSError *err;
        for (NSURL *mountUrl in mounted) {
            [mountUrl getResourceValue:&rsrcUrl forKey:NSURLVolumeURLForRemountingKey error:&err];
            rsrcUrl = [rsrcUrl absoluteURL];
            if (err != nil) {
                NSLog(@"Couldn't check the mount URL: %@", err);
                *error = @"Couldn't check the mount URL";
                break;
            } else if ([[rsrcUrl host] isEqualTo:[shareUrl host]] && [[rsrcUrl path] isEqualTo:[shareUrl path]] && [[rsrcUrl scheme] isEqualTo:[shareUrl scheme]]) {
                basepath = [mountUrl path];
                break;
            }
        }
    }
    if (basepath == nil) {
        *error = @"Could not locate the previously-mounted share";
        NSLog(@"Basepath is still nil, conceding defeat");
    } else {
        NSString *filepath = [[path subarrayWithRange:NSMakeRange(2, [path count]-2)] componentsJoinedByString:@"/"];
        NSURL *fileUrl = [[NSURL URLWithString:[NSString stringWithFormat: @"file://%@/%@", basepath, filepath]] absoluteURL];
        NSLog(@"Opening target file using URL \"%@\"", fileUrl);
        [[NSWorkspace sharedWorkspace] openURL:fileUrl];
    }
}
@end
