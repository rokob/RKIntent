//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>
#import <dispatch/queue.h>

@class RKIntent;
@protocol RKIntentHandler;

@interface RKIntentSource : NSObject

- (instancetype)initWithIdentifier:(NSString *)identifier
                     callbackQueue:(dispatch_queue_t)callbackQueue
                      successBlock:(void(^)(RKIntent *, id<RKIntentHandler>))successBlock
                      failureBlock:(void(^)(RKIntent *))failureBlock;

@property (nonatomic, readonly, copy) NSString *identifier;

- (void)didHandleIntent:(RKIntent *)intent withHandler:(id<RKIntentHandler>)handler;
- (void)failedToHandleIntent:(RKIntent *)intent;

@end
