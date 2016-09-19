
#import "BaseTest.h"
#import "TransferWS.h"
#import "TransferModel.h"
#import <OHPathHelpers.h>
#import "ErrorHandler.h"

@interface TransferWSTests : BaseTest

@end

@implementation TransferWSTests

- (void)testWSShouldReturnInternetConnectionError {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should be able to handle Internet Connection Problem"];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.path containsString:@"GetTransfers"];
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:999 userInfo:nil];
        return [OHHTTPStubsResponse responseWithError:error];
    }];
    
    NSURLSessionTask *task = [TransferWS loadTransfersWithCompletion:^(NSArray *array) {
        failure(@"This should not happen");
    } error:^(NSError *error) {
        expect(error.domain).to.equal(WSErrorDomain);
        expect(error.code).to.equal(ErrorHandlerCodeInternetConnection);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError * _Nullable error) {
        [task cancel];
    }];
}


- (void)testlWSShouldReturnBadRequestrOn4xx {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should be able to handle 4xx Error"];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.path containsString:@"GetTransfers"];
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        NSString *fixture = OHPathForFile(@"GetHistoryResponse.json", self.class);
        
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:400 headers:@{@"Content-Type" : @"application/json"}];
    }];
    
    NSURLSessionTask *task = [TransferWS loadTransfersWithCompletion:^(NSArray *array) {
        failure(@"This should not happen");
    } error:^(NSError *error) {
        expect(error.domain).to.equal(WSErrorDomain);
        expect(error.code).to.equal(ErrorHandlerCodeBadRequest);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError * _Nullable error) {
        [task cancel];
    }];
}

- (void)testWSShouldReturnServerErrorOn5xx {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should be able to handle 5xx Error"];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.path containsString:@"GetTransfers"];
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        NSString *fixture = OHPathForFile(@"GetHistoryResponse.json", self.class);
        
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:500 headers:@{@"Content-Type" : @"application/json"}];
    }];
    
    NSURLSessionTask *task = [TransferWS loadTransfersWithCompletion:^(NSArray *array) {
        failure(@"This should not happen");
    } error:^(NSError *error) {
        expect(error.domain).to.equal(WSErrorDomain);
        expect(error.code).to.equal(ErrorHandlerCodeServerError);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval handler:^(NSError * _Nullable error) {
        [task cancel];
    }];
}

- (void)testSuccessResponseGetHistory {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should be able to handle success Error"];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.path containsString:@"GetTransfers"];
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        NSString *fixture = OHPathForFile(@"GetHistoryResponse.json", self.class);
        
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200 headers:@{@"Content-Type" : @"application/json"}];
    }];
    
    NSURLSessionTask *task = [TransferWS loadTransfersWithCompletion:^(NSArray *array) {
        expect(array.count).to.beGreaterThanOrEqualTo(4);
        for (id model in array) {
            expect(model).to.beKindOf([TransferModel class]);
        }
        [expectation fulfill];
    } error:^(NSError *error) {
        failure(@"This should not happen");
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval
                                 handler:^(NSError * _Nullable error) {
                                     [task cancel];
                                 }];
}

- (void)testTokenWSCall {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should be able to handle 5xx Error"];
    
    NSURLSessionTask *task = [TransferWS loadUserToken:^(NSString *string) {
        expect(string).to.beAKindOf(NSString.class);
        [expectation fulfill];
    } error:^(NSError *error) {
        failure(@"This should not happen");
    }];
    
    [self waitForExpectationsWithTimeout:task.originalRequest.timeoutInterval
                                 handler:^(NSError * _Nullable error) {
                                     [task cancel];
                                 }];
}

@end
