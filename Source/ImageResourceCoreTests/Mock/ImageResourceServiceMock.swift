//
//  ImageResourceServiceMock.swift
//  ImageResourceCoreTests
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import Foundation
import ImageResourceAPI

final class ImageResourceServiceMock: ImageResourceService {
    typealias CompletionHandler = ((ImageResourceService.Result) -> Void)
    
    var completionHandlerCount: Int {
        completionHandler.count
    }
    var completionHandler = [CompletionHandler]()
    
    func retriveResouce(completion: @escaping (ImageResourceService.Result) -> Void) {
        completionHandler.append(completion)
    }
    
    func completeHandler(at index: Int = 0, with result: ImageResourceService.Result) {
        completionHandler[index](result)
    }
}
