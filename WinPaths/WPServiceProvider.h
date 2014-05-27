//
//  WPServiceProvider.h
//  WinPaths
//
//  Created by Timothy on 5/27/14.
//  Copyright (c) 2014 Timothy Woodford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPServiceProvider : NSObject
- (void)openLinkService:(NSPasteboard *)pboard userData:(NSString *)userData error:(NSString **)error;
@end
