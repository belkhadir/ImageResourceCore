//
//  ImageViewModel.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import Foundation
import ImageResourceAPI

protocol ImageViewDisplayable {
    var loadingState: LoadingState { get }
    
    func fetchImage()
}

final class ImageViewModel<ResourceProvider: ImageResourceService>: ObservableObject  {
    @Published private(set) var loadingState: LoadingState = .none
    
    private let service: ResourceProvider
    
    init(service: ResourceProvider) {
        self.service = service
    }
}

// MARK: - ImageViewDisplayable
extension ImageViewModel: ImageViewDisplayable {
    func fetchImage() {
        guard loadingState != .loading else { return }
        loadingState = .loading
        
        
        service.retriveResouce { [weak self] result in
            guard let self else { return }
            self.loadingState = .loaded(result: result)
        }
    }
}
