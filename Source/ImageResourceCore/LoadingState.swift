//
//  LoadingState.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import Foundation
import ImageResourceAPI

public enum LoadingState: Equatable {
    case none
    case loading
    case loaded(result: Result<ImageProviding, Error>)
    
    public static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.loading, .loading):
            return true
        case (.loaded(let lhsResult), .loaded(let rhsResult)):
            switch (lhsResult, rhsResult) {
            case (.success(let lhsImage), .success(let rhsImage)):
                return lhsImage.data == rhsImage.data
            case (.failure(let lhsError), .failure(let rhsError)):
                return (lhsError as NSError).domain == (rhsError as NSError).domain &&
                       (lhsError as NSError).code == (rhsError as NSError).code
            default:
                return false
            }
        default:
            return false
        }
    }
}

