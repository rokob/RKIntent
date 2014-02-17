//  Copyright (c) 2014 rokob. All rights reserved.

#import <Foundation/Foundation.h>

/**
 This enumeration describes the different types of intents that can be created. It will be extended.
 */
typedef NS_ENUM(NSUInteger, RKIntentType) {
  RKIntentTypeURL,
  RKIntentTypeObject,
  RKINtentTypeService
};

/**
 This enumeration describes the different actions that can be associated with an intent.
 */
typedef NS_ENUM(NSUInteger, RKIntentAction) {
  RKIntentActionView,
  RKIntentActionCreate,
  RKIntentActionSearch,
  RKIntentActionNavigate
};

@class RKIntentSource;

/**
 @summary A generic object that describes an intention to perform some action possibly with additional
 data provided for context.
 */
@protocol RKIntent <NSObject>
/// The type of the intent
- (RKIntentType)type;
/// The source of the intent
- (RKIntentSource *)source;
/// The action to take
- (RKIntentAction)action;
/// A data object to provide context for particular intents
- (id)payload;
@end

/**
 A generic intent object
 */
@interface RKIntent : NSObject <RKIntent>

/**
 Constructs the most generic type of intent object where the methods defined in @protocol `RKIntent` are satisfied
 by simply returning the parameters passed into this initializer.
 */
- (instancetype)initWithAction:(RKIntentAction)action
                          type:(RKIntentType)type
                        source:(RKIntentSource *)source
                       payload:(id)payload;
@end

/**
 A specialized type of intent for interacting with a URL
 */
@interface RKURLIntent : NSObject <RKIntent>

/**
 Construct a URL intent. This is a convenience initializer which sets the payload to nil
 
 @param action The action to take with the given URL
 @param source The source of the intent
 @param URL The URL this intent is for
 */
- (instancetype)initWithAction:(RKIntentAction)action
                        source:(RKIntentSource *)source
                           URL:(NSURL *)URL;

/**
 Construct a URL intent. This is the designated initializer.

 @param action The action to take with the given URL
 @param source The source of the intent
 @param URL The URL this intent is for
 @param payload Any extra payload data that is relevant to this intent
 */
- (instancetype)initWithAction:(RKIntentAction)action
                        source:(RKIntentSource *)source
                           URL:(NSURL *)URL
                       payload:(id)payload;

/// The URL this intent is for
- (NSURL *)URL;

@end
