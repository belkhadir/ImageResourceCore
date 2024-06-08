//
//  ImageViewModelTests.swift
//  ImageResourceCoreTests
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import XCTest
import ImageResourceAPI
@testable import ImageResourceCore

final class ImageViewModelTests: XCTestCase {
    func testWhenNotFetchingImage_ThenLoadingStateIsNone() {
        let (sut, _) = makeSUT()
        
        XCTAssertEqual(sut.loadingState, .none)
    }
    
    func testWhenFetchImageAndNoResult_ThenLoadingStateIsLoading() {
        let (sut, _) = makeSUT()
        sut.fetchImage()
        
        XCTAssertEqual(sut.loadingState, .loading)
    }
    
    func testWhenFetchImageAndResultIsFailure_ThenLoadingStateIsLoadedWithFailureResult() {
        let (sut, mock) = makeSUT()
        sut.fetchImage()
        
        mock.completeHandler(with: .failure(anyError))
        
        XCTAssertEqual(sut.loadingState, .loaded(result: .failure(anyError)))
    }
    
    func testWhenFetchImageAndResultIsSuccess_ThenLoadingStateIsLoadedWithSuccessResult() {
        let (sut, mock) = makeSUT()
        sut.fetchImage()
            
        let data = AnyImageProvider()
        mock.completeHandler(with: .success(data))
        
        XCTAssertEqual(sut.loadingState, .loaded(result: .success(data)))
    }
    
    func testGivenLoadingStateisLoading_WhenFetchImageTwice_ThenRetriveResouceCalledOnce() {
        let (sut, mock) = makeSUT()
        sut.fetchImage()
        sut.fetchImage()
        
        XCTAssertEqual(mock.completionHandlerCount, 1)
    }
}

// MARK: - Helpers
private extension ImageViewModelTests {
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: any ImageViewDisplayable, mock: ImageResourceServiceMock) {
        let mock = ImageResourceServiceMock()
        let viewModel = ImageViewModel(service: mock)
        trackMemoryLeak(mock, file: file, line: line)
        trackMemoryLeak(viewModel, file: file, line: line)
        return (viewModel, mock)
    }
    
    var anyError: NSError {
        NSError(domain: "any error", code: 1)
    }
    
    struct AnyImageProvider: ImageProviding {
        var data = Data()
    }
    
    func trackMemoryLeak(_ object: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak object] in
            XCTAssertNil(
                object,
                "Potential memory leak detected. Expected object to be nil but found \(String(describing: object)).",
                file: file,
                line: line
            )
        }
    }
}
