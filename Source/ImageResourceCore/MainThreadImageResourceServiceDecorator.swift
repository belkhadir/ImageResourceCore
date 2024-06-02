//
//  MainThreadImageResourceServiceDecorator.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 2/6/2024.
//

import ImageResourceAPI
import Foundation

final class MainThreadImageResourceServiceDecorator<Service: ImageResourceService> {
    private let decoratee: Service
    
    init(decoratee: Service) {
        self.decoratee = decoratee
    }
}

// MARK: - ImageResourceService
extension MainThreadImageResourceServiceDecorator: ImageResourceService {
    func retriveResouce(completion: @escaping (ImageResourceService.Result) -> Void) {
        decoratee.retriveResouce { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
