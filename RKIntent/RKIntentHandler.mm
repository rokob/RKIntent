//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKIntentHandler.h"
#import "RKIntent.h"
#import "RKIntentSource.h"

#include <algorithm>
#include <vector>

@implementation RKIntentHandler
{
  id<RKIntentHandler> _parentHandler;
}

- (id)init
{
  return [self initWithParent:nil];
}

- (id)initWithParent:(id<RKIntentHandler>)parent
{
  if ((self = [super init])) {
    _parentHandler = parent;
  }
  return self;
}

- (BOOL)handleIntent:(id<RKIntent>)intent
{
  if (_parentHandler) {
    return [_parentHandler handleIntent:intent];
  }

  RKIntentSource *source = [intent source];
  [source failedToHandleIntent:intent];

  return NO;
}

+ (BOOL)canHandleIntent:(id<RKIntent>)intent
{
  return NO;
}

- (id<RKIntentHandler>)parent
{
  return _parentHandler;
}

@end

@implementation RKBroadcastIntentHandler
{
  std::vector<id<RKIntentHandler>> _targets;
  id<RKIntentHandler> _parent;
}

- (id)init
{
  return [self initWithParent:nil];
}

- (id)initWithParent:(id<RKIntentHandler>)parent
{
  if ((self = [super init])) {
    _parent = parent;
  }
  return self;
}

- (void)addHandler:(id<RKIntentHandler>)handler
{
  _targets.push_back(handler);
}

- (void)removeHandler:(id<RKIntentHandler>)handler
{
  auto handlerIt = std::find(_targets.begin(), _targets.end(), handler);
  if (handlerIt != _targets.end()) {
    _targets.erase(handlerIt);
  }
}

- (BOOL)handleIntent:(id<RKIntent>)intent
{
  BOOL handled = NO;
  RKIntentSource *source = [intent source];
  for (auto target : _targets) {
    if ([target handleIntent:intent]) {
      handled = YES;
      [source didHandleIntent:intent withHandler:target];
    }
  }
  if (!handled && _parent) {
    return [_parent handleIntent:intent];
  }
  if (!handled) {
    [source failedToHandleIntent:intent];
  }
  return handled;
}

+ (BOOL)canHandleIntent:(id<RKIntent>)intent
{
  return YES;
}

- (id<RKIntentHandler>)parent
{
  return _parent;
}

@end
