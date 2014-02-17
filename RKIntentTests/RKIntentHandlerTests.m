//  Copyright (c) 2014 rokob. All rights reserved.

#import <XCTest/XCTest.h>
#import <Specta/Specta.h>
#import <OCMock/OCMock.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "RKIntent.h"
#import "RKIntentHandler.h"
#import "RKIntentSource.h"

SpecBegin(IntentHandler)

describe(@"the root handler", ^{

  __block RKIntentHandler *handler;

  beforeEach(^{
    handler = [[RKIntentHandler alloc] initWithParent:nil];
  });

  it(@"should notify source upon failure", ^{
    id mockSource = [OCMockObject mockForClass:[RKIntentSource class]];

    RKIntent *intent = [[RKIntent alloc] initWithData:nil type:RKIntentTypeObject source:mockSource];
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
    RKIntent *intent = [[RKIntent alloc] initWithData:nil type:RKIntentTypeObject source:source];

    [handler handleIntent:intent];
  });
});

describe(@"handler chains", ^{
  it(@"should notify it's parent if it doesn't handle the intent", ^{
    id mockParent = [OCMockObject mockForClass:[RKIntentHandler class]];

    RKIntentHandler *handler = [[RKIntentHandler alloc] initWithParent:mockParent];

    id mockIntent = [OCMockObject mockForClass:[RKIntent class]];
    [[mockParent expect] handleIntent:mockIntent];

    [handler handleIntent:mockIntent];

    [mockParent verify];
  });
});

SpecEnd