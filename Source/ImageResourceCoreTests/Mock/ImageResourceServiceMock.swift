//
//  ImageResourceServiceMock.swift
//  ImageResourceCoreTests
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import Foundation
import ImageResourceAPI

final class ImageResourceServiceMock: ImageResourceService {

    var invokedRetriveResouce = false
    var invokedRetriveResouceCount = 0
    var stubbedRetriveResouceCompletionResult: ImageResourceService.Result?

    func retriveResouce(completion: @escaping (ImageResourceService.Result) -> Void) {
        invokedRetriveResouce = true
        invokedRetriveResouceCount += 1
        if let result = stubbedRetriveResouceCompletionResult {
            completion(result)
        }
    }
}
