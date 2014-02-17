//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

@class RKIntent;

@protocol RKIntentHandler <NSObject>

- (instancetype)init;
- (instancetype)initWithParent:(id<RKIntentHandler>)parent;

- (BOOL)handleIntent:(RKIntent *)intent;

+ (BOOL)canHandleIntent:(RKIntent *)intent;

@end

@interface RKIntentHandler : NSObject <RKIntentHandler>

@end
