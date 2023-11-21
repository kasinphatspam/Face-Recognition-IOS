//
//  CirculeImage.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 12/11/2566 BE.
//

import SwiftUI

struct CircleImage: View {
    
    private let url: String
    
    init(image: String) {
        self.url = image
    }
    var body: some View {
        AsyncImage(url: URL(string: url)
        ) {
            phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 36, height: 36)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .clipShape(Circle())
                        .frame(width: 36, height: 36)
                case .failure:
                    Image(uiImage: UIImage(named: "default")!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .clipShape(Circle())
                        .frame(width: 36, height: 36)
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
        }
    }
}

struct ProfileCircleImage: View {
    
    private let url: String
    
    init(image: String) {
        self.url = image
    }
    var body: some View {
        AsyncImage(url: URL(string: url)
        ) {
            phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                case .failure:
                    Image(uiImage: UIImage(named: "default")!)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
        }
    }
}

#Preview {
    CircleImage(image: "")
}
