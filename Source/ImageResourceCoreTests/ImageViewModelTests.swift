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
    func testWhenFetchImageAndNoResult_ThenLoadingStateIsLoading() {
        let (sut, mock) = makeSUT()
        mock.stubbedRetriveResouceCompletionResult = nil
        sut.fetchImage()
        XCTAssertEqual(sut.loadingState, .loading)
    }
    
    func testWhenFetchImageAndResultIsFailure_ThenLoadingStateIsLoadedWithFailureResult() {
        let (sut, mock) = makeSUT()
        mock.stubbedRetriveResouceCompletionResult = .failure(anyError)
        sut.fetchImage()
        
        let expectedResult: LoadingState = .loaded(result: .failure(anyError))
        XCTAssertEqual(sut.loadingState, expectedResult)
    }
    
    func testWhenFetchImageAndResultIsSuccess_ThenLoadingStateIsLoadedWithSuccessResult() {
        let (sut, mock) = makeSUT()
        let data = AnyImageProvider()
        mock.stubbedRetriveResouceCompletionResult = .success(data)
        sut.fetchImage()
        
        let expectedResult: LoadingState = .loaded(result: .success(data))
        XCTAssertEqual(sut.loadingState, expectedResult)
    }
}

// MARK: - Helpers
private extension ImageViewModelTests {
    func makeSUT() -> (sut: any ImageViewDisplayable, mock: ImageResourceServiceMock) {
        let mock = ImageResourceServiceMock()
        let viewModel = ImageViewModel(service: mock)
        return (viewModel, mock)
    }
    
    var anyError: NSError {
        NSError(domain: "any error", code: 1)
    }
    
    struct AnyImageProvider: ImageProviding {
        var data = Data()
    }
}
