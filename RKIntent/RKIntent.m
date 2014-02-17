//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKIntent.h"

#import "RKIntentSource.h"

@implementation RKIntent
{
  id _data;
  RKIntentType _type;
  RKIntentSource *_source;
}

- (id)initWithData:(id)data type:(RKIntentType)type source:(RKIntentSource *)source
{
  if ((self = [super init])) {
    _data = data;
    _type = type;
    _source = source;
  }
  return self;
}

- (id)data
{
  return _data;
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
  RKIntentSource *_source;
}

- (id)initWithURL:(NSURL *)URL source:(RKIntentSource *)source
{
  if ((self = [super init])) {
    _URL = [URL copy];
    _source = source;
  }
  return self;
}

- (NSURL *)URL
{
  return _URL;
}

- (RKIntentType)type
{
  return RKIntentTypeURL;
}

- (RKIntentSource *)source
{
  return _source;
}

@end
