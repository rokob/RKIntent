//  Copyright (c) 2014 rokob. All rights reserved.

#import "RKIntentHandler.h"
#import "RKIntent.h"
#import "RKIntentSource.h"

@implementation RKIntentHandler
{
  RKIntentHandler *_parentHandler;
}

- (id)init
{
  return [self initWithParent:nil];
}

- (id)initWithParent:(RKIntentHandler *)parent
{
  if ((self = [super init])) {
    _parentHandler = parent;
  }
  return self;
}

- (BOOL)handleIntent:(RKIntent *)intent
{
  if (_parentHandler) {
    return [_parentHandler handleIntent:intent];
  }

  RKIntentSource *source = [intent source];
  [source failedToHandleIntent:intent];

  return NO;
}

+ (BOOL)canHandleIntent:(RKIntent *)intent
{
  return NO;
}

@end
