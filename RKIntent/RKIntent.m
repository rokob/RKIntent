//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKIntent.h"

#import "RKIntentSource.h"

@implementation RKIntent
{
  id _payload;
  RKIntentType _type;
  RKIntentAction _action;
  RKIntentSource *_source;
}

- (id)initWithAction:(RKIntentAction)action
                type:(RKIntentType)type
              source:(RKIntentSource *)source
             payload:(id)payload
{
  if ((self = [super init])) {
    _action = action;
    _payload = payload;
    _type = type;
    _source = source;
  }
  return self;
}

- (id)payload
{
  return _payload;
}

- (RKIntentAction)action
{
  return _action;
}

- (RKIntentType)type
{
  return _type;
}

- (RKIntentSource *)source
{
  return _source;
}

@end

@implementation RKURLIntent
{
  NSURL *_URL;
  id _payload;
  RKIntentAction _action;
  RKIntentSource *_source;
}

- (id)initWithAction:(RKIntentAction)action source:(RKIntentSource *)source URL:(NSURL *)URL
{
  return [self initWithAction:action source:source URL:URL payload:nil];
}

- (id)initWithAction:(RKIntentAction)action source:(RKIntentSource *)source URL:(NSURL *)URL payload:(id)payload
{
  if ((self = [super init])) {
    _URL = [URL copy];
    _source = source;
    _action = action;
    _payload = payload;
  }
  return self;
}

- (NSURL *)URL
{
  return _URL;
}

- (id)payload
{
  return _payload;
}

- (RKIntentType)type
{
  return RKIntentTypeURL;
}

- (RKIntentSource *)source
{
  return _source;
}

- (RKIntentAction)action
{
  return _action;
}

@end
