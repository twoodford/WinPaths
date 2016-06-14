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
    //NSLog(@"inurl=%@", inurl);
    NSURL *url;
    NSError *__autoreleasing *err;
    [inurl getResourceValue:&url forKey:NSURLVolumeURLForRemountingKey error:err];
    url = [url absoluteURL];
    if (err!=NULL) {
        NSLog(@"url=%@", url);
        //DBG NSLog(@"Error determining mount URL: %@", err);
    }
    NSArray *components = [inurl pathComponents];
    components = [components subarrayWithRange:NSMakeRange(3, [components count] - 3)];
    NSString *normalized2 = [components componentsJoinedByString:@"\\"];
    //DBG NSLog(@"path2=%@", normalized2);
    components = [url pathComponents];
    components = [components subarrayWithRange:NSMakeRange(1, [components count] - 1)];
    NSString *normalized1 = [components componentsJoinedByString:@"\\"];
    //DBG NSLog(@"path1=%@", normalized1);
    // Get hostname
    NSString *normhost = [[[url host] componentsSeparatedByString:@"."] objectAtIndex:0];
    //DBG NSLog(@"host=%@", normhost);
    NSString *winpath = [NSString stringWithFormat:@"\\\\%@\\%@\\%@", normhost, normalized1, normalized2];
    
    
    [[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
    [[NSPasteboard generalPasteboard] setString:winpath forType:NSPasteboardTypeString];
}
@end
