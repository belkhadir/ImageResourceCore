//
//  ConstructImageView.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import ImageResourceAPI
import SwiftUI

public struct ImagePosterViewProvider<Service: ImageResourceService> {
    private let service: Service
    private let imageStyle: ImageStyling
    
    public init(service: Service, imageStyle: ImageStyling) {
        self.service = service
        self.imageStyle = imageStyle
    }
}

// MARK: - ImageResourceServiceProviding
extension ImagePosterViewProvider: ImageResourceServiceProviding {
    public func imageView() -> some View {
        let decorateeService = MainThreadImageResourceServiceDecorator(decoratee: service)
        let viewModel = ImageViewModel(service: decorateeService)
        let view = ImageView(viewModel: viewModel).imageStyle(imageStyle)
        return view
    }
}
