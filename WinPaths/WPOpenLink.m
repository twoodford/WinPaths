//
//  WPOpenLink.m
//  WinPaths
//
//  Created by Timothy on 5/27/14.
//  Copyright (c) 2014 Timothy Woodford. All rights reserved.
//

#import "WPOpenLink.h"

@implementation WPOpenLink
+(void) openLink: (NSString *) link error:(NSString **) error
{
    NSString *slashed = [link stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"smb:%@", slashed]];
    NSLog(@"slashed=%@", url);
    [[NSWorkspace sharedWorkspace] openURL:url];
}
@end
