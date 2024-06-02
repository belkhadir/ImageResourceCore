//
//  ConstructImageView.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import ImageResourceAPI
import SwiftUI

public struct ConstructImageView {
    static public func constructView<Service: ImageResourceService>(service: Service, imageStyle: ImageStyling) -> some View {
        let decorateeService = MainThreadImageResourceServiceDecorator(decoratee: service)
        let viewModel = ImageViewModel(service: decorateeService)
        let view = ImageView(viewModel: viewModel).imageStyle(imageStyle)
        return view
    }
}
