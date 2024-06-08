//
//  ImageProviderMock.swift
//  ImageResourceCoreTests
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import Foundation
import ImageResourceAPI

final class ImageProviderMock: ImageProviding {

    var invokedDataGetter = false
    var invokedDataGetterCount = 0
    var stubbedData: Data!

    var data: Data {
        invokedDataGetter = true
        invokedDataGetterCount += 1
        return stubbedData
    }
}
