//
//  ImageView.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import SwiftUI

struct ImageView<ViewModel: ImageViewDisplayable & ObservableObject>: View {
    @Environment(\.imageStyle) var imageStyle
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading, .none:
                ShimmerView()
            case .loaded(let result):
                switch result {
                case let .success(imageProviding): image(from: imageProviding.data)
                case .failure: retryLoadImage
                }
            }
        }.onAppear {
            viewModel.fetchImage()
        }
    }
}

// MARK: - Helpers
private extension ImageView {
    func image(from data: Data) -> some View {
        Image(data: data)
            .resizable()
            .frame(width: imageStyle.frame.width, height: imageStyle.frame.height)
            .scaledToFit()
            .clipped()
            .cornerRadius(imageStyle.cornerRadius)
            .shadow(radius: imageStyle.shadowRadius)
    }
    
    var retryLoadImage: some View {
        Button(action: {
            viewModel.fetchImage()
        }, label: {
            Image(systemName: "xmark.octagon")
                .frame(width: 150, height: 200)
        })
    }
}
