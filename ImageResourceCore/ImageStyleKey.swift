//
//  ImageStyleKey.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import SwiftUI

struct ImageStyleKey: EnvironmentKey {
    static var defaultValue: ImageStyling = ImagePoster()
}

struct ImagePoster: ImageStyling {
    var frame: CGSize {
        .init(width: 150.0, height: 200.0)
    }
    
    var cornerRadius: Double {
        10.0
    }
    
    var shadowRadius: Double {
        5.0
    }
}
