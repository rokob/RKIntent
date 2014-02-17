//  Copyright (c) 2014 rokob. All rights reserved.

#import <XCTest/XCTest.h>
#import <Specta/Specta.h>
#import <OCMock/OCMock.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "RKIntent.h"
#import "RKIntentHandler.h"
#import "RKIntentSource.h"

SpecBegin(BasicIntentHandler)

describe(@"the root handler", ^{

  __block RKIntentHandler *handler;

  beforeEach(^{
    handler = [[RKIntentHandler alloc] initWithParent:nil];
  });

  it(@"should notify source upon failure", ^{
    id mockSource = [OCMockObject mockForClass:[RKIntentSource class]];

    RKIntent *intent = [[RKIntent alloc] initWithAction:RKIntentActionView
                                                   type:RKIntentTypeObject
                                                 source:mockSource
                                                payload:nil];
    [[mockSource expect] failedToHandleIntent:intent];

    [handler handleIntent:intent];

    [mockSource verify];
  });

  it(@"should execute failure block", ^AsyncBlock{
    RKIntentSource *source = [[RKIntentSource alloc] initWithIdentifier:@"source"
                                                          callbackQueue:dispatch_get_main_queue()
                                                           successBlock:^(RKIntent *i, id<RKIntentHandler> h) {
                                                             XCTFail(@"success should not be called");
                                                           }
                                                           failureBlock:^(RKIntent *intent) {
                                                             done();
                                                           }];
    RKIntent *intent = [[RKIntent alloc] initWithAction:RKIntentActionCreate
                                                   type:RKIntentTypeObject
                                                 source:source
                                                payload:nil];

    [handler handleIntent:intent];
  });
});

describe(@"handler chains", ^{
  it(@"should notify its parent if it doesn't handle the intent", ^{
    id mockParent = [OCMockObject mockForClass:[RKIntentHandler class]];

    RKIntentHandler *handler = [[RKIntentHandler alloc] initWithParent:mockParent];

    id mockIntent = [OCMockObject mockForClass:[RKIntent class]];
    [[mockParent expect] handleIntent:mockIntent];

    [handler handleIntent:mockIntent];

    [mockParent verify];
  });
});

SpecEnd

SpecBegin(BroadcastIntentHandler)

__block id mockIntent;

beforeEach(^{
  mockIntent = [OCMockObject mockForProtocol:@protocol(RKIntent)];
  [[[mockIntent stub] andReturn:nil] source];
});

describe(@"basic broadcast functionality", ^{
  it(@"should broadcast to one", ^{
    id mockHandler = [OCMockObject mockForProtocol:@protocol(RKIntentHandler)];

    RKBroadcastIntentHandler *broadcastHandler = [[RKBroadcastIntentHandler alloc] init];
    [broadcastHandler addHandler:mockHandler];

    [[[mockHandler expect] andReturnValue:@YES] handleIntent:mockIntent];

    [broadcastHandler handleIntent:mockIntent];

    [mockHandler verify];
  });

  it(@"should not call when the handler is removed", ^{
    id mockHandler  = [OCMockObject mockForProtocol:@protocol(RKIntentHandler)];

    RKBroadcastIntentHandler *broadcastHandler = [[RKBroadcastIntentHandler alloc] init];
    [broadcastHandler addHandler:mockHandler];

    [broadcastHandler removeHandler:mockHandler];

    [broadcastHandler handleIntent:mockIntent];

    [mockHandler verify];
  });

  it(@"should allow multiple handlers", ^{
    id mockHandler  = [OCMockObject mockForProtocol:@protocol(RKIntentHandler)];
    id mockHandler2 = [OCMockObject mockForProtocol:@protocol(RKIntentHandler)];

    RKBroadcastIntentHandler *broadcastHandler = [[RKBroadcastIntentHandler alloc] init];
    [broadcastHandler addHandler:mockHandler];
    [broadcastHandler addHandler:mockHandler2];

    [[[mockHandler expect] andReturnValue:@YES] handleIntent:mockIntent];
    [[[mockHandler2 expect] andReturnValue:@YES] handleIntent:mockIntent];

    [broadcastHandler handleIntent:mockIntent];

    [mockHandler verify];
    [mockHandler2 verify];
  });

  it(@"should allow multiple handlers to be added and some to be removed", ^{
    id mockHandler  = [OCMockObject mockForProtocol:@protocol(RKIntentHandler)];
    id mockHandler2 = [OCMockObject mockForProtocol:@protocol(RKIntentHandler)];

    RKBroadcastIntentHandler *broadcastHandler = [[RKBroadcastIntentHandler alloc] init];
    [broadcastHandler addHandler:mockHandler];
    [broadcastHandler addHandler:mockHandler2];

    [[[mockHandler2 expect] andReturnValue:@YES] handleIntent:mockIntent];

    [broadcastHandler removeHandler:mockHandler];

    [broadcastHandler handleIntent:mockIntent];

    [mockHandler verify];
    [mockHandler2 verify];
  });
});

SpecEnd