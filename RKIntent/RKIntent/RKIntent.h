//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RKIntentType) {
  RKIntentTypeURL,
  RKIntentTypeObject
};

@protocol RKIntent <NSObject>
- (RKIntentType)type;
@end

@interface RKIntent : NSObject <RKIntent>

- (instancetype)initWithData:(id)data type:(RKIntentType)type;

- (id)data;

@end
