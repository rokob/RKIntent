//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RKIntentType) {
  RKIntentTypeURL,
  RKIntentTypeObject
};

@class RKIntentSource;

@protocol RKIntent <NSObject>
- (RKIntentType)type;
- (RKIntentSource *)source;
@end

@interface RKIntent : NSObject <RKIntent>

- (instancetype)initWithData:(id)data type:(RKIntentType)type source:(RKIntentSource *)source;
- (id)data;

@end

@interface RKURLIntent : NSObject <RKIntent>

- (instancetype)initWithURL:(NSURL *)URL source:(RKIntentSource *)source;
- (NSURL *)URL;

@end
