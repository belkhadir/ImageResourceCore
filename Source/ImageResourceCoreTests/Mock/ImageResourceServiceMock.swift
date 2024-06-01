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

    var retainCycle: ((ImageResourceService.Result) -> Void)?
    
    func retriveResouce(completion: @escaping (ImageResourceService.Result) -> Void) {
        invokedRetriveResouce = true
        invokedRetriveResouceCount += 1
        retainCycle = completion
        if let result = stubbedRetriveResouceCompletionResult {
            completion(result)
        }
    }
}
