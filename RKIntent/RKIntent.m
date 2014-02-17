//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKIntent.h"

@implementation RKIntent
{
  id _data;
  RKIntentType _type;
}

- (id)initWithData:(id)data type:(RKIntentType)type
{
  if ((self = [super init])) {
    _data = data;
    _type = type;
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

@end
