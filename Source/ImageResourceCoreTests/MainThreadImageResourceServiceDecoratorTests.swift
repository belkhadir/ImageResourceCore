//
//  MainThreadImageResourceServiceDecoratorTests.swift
//  ImageResourceCoreTests
//
//  Created by Belkhadir Anas on 2/6/2024.
//

import XCTest
import ImageResourceAPI
@testable import ImageResourceCore

final class MainThreadImageResourceServiceDecoratorTests: XCTestCase {
    func testGivenImageResourceService_WhenRetriveResouceCalled_ThenDeliversResultOnMainThread() {
        let (sut, mock) = makeSUT()
        
        let exp = expectation(description: "Waiting for completion")
        
        sut.retriveResouce { result in
            XCTAssertTrue(Thread.isMainThread)
            exp.fulfill()
        }
        
        let imageProvider = ImageProviderMock()
        imageProvider.stubbedData = .init()
        mock.completeHandler(with: .success(imageProvider))
        wait(for: [exp], timeout: 1.0)
    }
    
    func testGivenSuccessfulImageProvider_WhenRetriveResouceCalled_ThenPassesResult() {
        let (sut, mock) = makeSUT()
        
        let imageProviderMock = ImageProviderMock()
        imageProviderMock.stubbedData = .init()
        
        assertThat(sut, mock: mock, expectedResult: .success(imageProviderMock))
    }
    
    func testGivenError_WhenRetriveResouceCalled_ThenPassesErrorResult() {
        let (sut, mock) = makeSUT()
        
        assertThat(sut, mock: mock, expectedResult: .failure(anyError()))
    }
}

// MARK: - Helpers
private extension MainThreadImageResourceServiceDecoratorTests {
    func makeSUT() -> (sut: ImageResourceService, mock: ImageResourceServiceMock) {
        let mock = ImageResourceServiceMock()
        let mainThread = MainThreadImageResourceServiceDecorator(decoratee: mock)
        return (mainThread, mock)
    }
    
    func assertThat(
        _ sut: ImageResourceService,
        mock: ImageResourceServiceMock,
        expectedResult:  ImageResourceService.Result,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "waiting for completion")
        sut.retriveResouce { result in
            switch (result, expectedResult) {
            case (.success(let receivedResult), .success(let expectedResult)):
                XCTAssertEqual(receivedResult.data, expectedResult.data, file: file, line: line)
            case (.failure(let receivedError as NSError), .failure(let expectedError as NSError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) but got \(result)", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        mock.completeHandler(with: expectedResult)
        wait(for: [exp], timeout: 1)
    }
    
    func anyError() -> NSError {
        NSError(domain: "any error", code: 1)
    }
}
