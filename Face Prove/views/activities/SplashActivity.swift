//
//  SplashView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

struct SplashActivity: View {
    var body: some View {
        VStack{
            Spacer()
            
            Text("Face Prove")
                .font(.title)
                .multilineTextAlignment(.center)
                .bold()
            
            
            Spacer()
            Text("Copyright © 2023 Face Prove.inc").font(.system(size: 12)).padding(24)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    SplashActivity()
}
