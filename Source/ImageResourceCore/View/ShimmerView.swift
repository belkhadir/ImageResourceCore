//
//  ShimmerView.swift
//  ImageResourceCore
//
//  Created by Belkhadir Anas on 1/6/2024.
//

import SwiftUI

struct ShimmerView: View {
    @State private var shimmerPhase: CGFloat = -1.0
    
    init() {}
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.white.opacity(0.75),
                Color.white,
                Color.white.opacity(0.75)
            ]),
            startPoint: .init(x: shimmerPhase, y: 0.5),
            endPoint: .init(x: shimmerPhase + 1.0, y: 0.5)
        )
        .frame(width: 150, height: 200)
        .background(Color.gray.opacity(0.9))
        .clipped()
        .cornerRadius(10)
        .shadow(radius: 5)
        .onAppear() {
            withAnimation(Animation.linear(duration: 1.35).repeatForever(autoreverses: false)) {
                shimmerPhase = 1.0
            }
        }
    }
}

#Preview {
    ShimmerView()
}
