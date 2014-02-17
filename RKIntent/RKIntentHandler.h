//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

@protocol RKIntent;

@protocol RKIntentHandler <NSObject>

/**
 This method gives an intent to the receiver for processing. The receiver can choose to do whatever it wants
 in response to the call as long as it returns YES/NO to signify success/failure to handle the intent.

 @param intent A properly configured object which specifies the intent of what the caller wishes to do
 @return YES if the receiver handled the intent
 */
- (BOOL)handleIntent:(id<RKIntent>)intent;

@optional
/**
 This is intended to be a hint as to whether the handler cannot handle the intent. A default implementation
 should return YES to signify that (@see `handleIntent:`) should be called to determine whether or not a handler
 actually will handle a particular intent. In other words, returning YES from this method does not imply
 that (@see `handleIntent:`) will also return YES.
 
 @param intent A properly configured object which specifies the intent of what the caller wishes to do
 @return NO if this handler knows it absolutely cannot handle this intent, YES otherwise
 */
+ (BOOL)canHandleIntent:(id<RKIntent>)intent;

/**
 A handler can optionally choose to form a chain of handlers by using this method to move upwards in a chain.
 As this is optional, there is no guarantee that a particular intent handler is part of a chain.
 */
- (id<RKIntentHandler>)parent;

@end

@interface RKIntentHandler : NSObject <RKIntentHandler>

- (instancetype)init;
- (instancetype)initWithParent:(id<RKIntentHandler>)parent;

@end

@interface RKBroadcastIntentHandler : NSObject <RKIntentHandler>

- (instancetype)init;
- (instancetype)initWithParent:(id<RKIntentHandler>)parent;

- (void)addHandler:(id<RKIntentHandler>)handler;
- (void)removeHandler:(id<RKIntentHandler>)handler;

@end
