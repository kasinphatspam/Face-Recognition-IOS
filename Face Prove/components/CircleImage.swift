//
//  CirculeImage.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 12/11/2566 BE.
//

import SwiftUI

struct CircleImage: View {
    
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    var body: some View {
        Image(uiImage: self.image)
            .resizable()
            .clipShape(Circle())
            .frame(width: 36, height: 36)
    }
}

#Preview {
    CircleImage(image: UIImage(named: "mahiru")!)
}
