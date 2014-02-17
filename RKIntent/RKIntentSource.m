//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKIntentSource.h"

@implementation RKIntentSource
{
  dispatch_queue_t _callbackQueue;
  void(^_successBlock)(id<RKIntent>, id<RKIntentHandler>);
  void(^_failureBlock)(id<RKIntent>);
  NSString *_identifier;
}

- (id)initWithIdentifier:(NSString *)identifier
           callbackQueue:(dispatch_queue_t)callbackQueue
            successBlock:(void (^)(id<RKIntent>, id<RKIntentHandler>))successBlock
            failureBlock:(void (^)(id<RKIntent>))failureBlock
{
  if ((self = [super init])) {
    _identifier = [identifier copy];
    _callbackQueue = callbackQueue;
    _successBlock = [successBlock copy];
    _failureBlock = [failureBlock copy];
  }
  return self;
}

- (void)didHandleIntent:(id<RKIntent>)intent withHandler:(id<RKIntentHandler>)handler
{
  if (!_successBlock) return;

  dispatch_async(_callbackQueue, ^{
    _successBlock(intent, handler);
  });
}

- (void)failedToHandleIntent:(id<RKIntent>)intent
{
  if (!_failureBlock) return;

  dispatch_async(_callbackQueue, ^{
    _failureBlock(intent);
  });
}

@end
