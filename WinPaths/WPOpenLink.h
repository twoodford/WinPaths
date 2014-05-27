//
//  WPOpenLink.h
//  WinPaths
//
//  Created by Timothy on 5/27/14.
//  Copyright (c) 2014 Timothy Woodford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPOpenLink : NSObject
+(void) openLink: (NSString *) link error:(NSString **) error;
@end
