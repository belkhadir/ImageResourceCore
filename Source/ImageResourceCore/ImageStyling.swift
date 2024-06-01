//
//  ImageStyling.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import Foundation

public protocol ImageStyling {
    var frame: CGSize { get }
    var cornerRadius: Double { get }
    var shadowRadius: Double { get }
}
