//
//  WPCopyPath.m
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

#import "WPCopyPath.h"

@implementation WPCopyPath
+ (void) copyPath: (NSURL *)inurl
{
    NSArray *components = [inurl pathComponents];
    // Find /Volume/*/ part of path only (needed for finding server URL because Apple is annoying)
    NSURL *volurl = [NSURL URLWithString:[NSString stringWithFormat:@"file:///%@/%@", components[1], components[2]]];
    //DBG NSLog(@"volurl=%@", volurl);
    // Last part of output (remove /Volumes/*/)
    NSString *normalized2 = [[components subarrayWithRange:NSMakeRange(3, [components count] - 3)]
                             componentsJoinedByString:@"\\"];
    //DBG NSLog(@"path2=%@", normalized2);
    // Server URL
    NSURL *srvurl;
    NSError *__autoreleasing *err;
    [volurl getResourceValue:&srvurl forKey:NSURLVolumeURLForRemountingKey error:err];
    //DBG NSLog(@"url=%@", srvurl);
    if (err!=NULL) {
        NSLog(@"volurl=%@", volurl);
        //DBG NSLog(@"Error determining mount URL: %@", err);
    }
    // Get hostname
    NSString *normhost = [srvurl host];
    //DBG NSLog(@"host=%@", normhost);
    NSString *winpath = [NSString stringWithFormat:@"\\\\%@\\%@\\%@", normhost, [srvurl lastPathComponent], normalized2];
    
    
    [[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
    [[NSPasteboard generalPasteboard] setString:winpath forType:NSPasteboardTypeString];
}
@end
