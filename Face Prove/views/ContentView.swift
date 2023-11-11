//
//  ContentView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            if self.isActive {
                LoginActivity()
            } else {
                SplashActivity()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
