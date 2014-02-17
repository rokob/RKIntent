//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKIntentSource.h"

@implementation RKIntentSource
{
  dispatch_queue_t _callbackQueue;
  void(^_successBlock)(RKIntent *, id<RKIntentHandler>);
  void(^_failureBlock)(RKIntent *);
  NSString *_identifier;
}

- (id)initWithIdentifier:(NSString *)identifier
           callbackQueue:(dispatch_queue_t)callbackQueue
            successBlock:(void (^)(RKIntent *, id<RKIntentHandler>))successBlock
            failureBlock:(void (^)(RKIntent *))failureBlock
{
  if ((self = [super init])) {
    _identifier = [identifier copy];
    _callbackQueue = callbackQueue;
    _successBlock = [successBlock copy];
    _failureBlock = [failureBlock copy];
  }
  return self;
}

- (void)didHandleIntent:(RKIntent *)intent withHandler:(id<RKIntentHandler>)handler
{
  if (!_successBlock) return;

  dispatch_async(_callbackQueue, ^{
    _successBlock(intent, handler);
  });
}

- (void)failedToHandleIntent:(RKIntent *)intent
{
  if (!_failureBlock) return;

  dispatch_async(_callbackQueue, ^{
    _failureBlock(intent);
  });
}

@end
