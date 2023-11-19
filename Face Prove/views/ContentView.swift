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
    @State var isLogin: Bool = false

    var body: some View {
        ZStack {
            if self.isActive && !isLogin {
                LoginActivity()
            } else if self.isActive && isLogin {
                MainActivity()
            }
            else {
                SplashActivity().onAppear() {
                    Task {
                        try await viewModel.fetch()
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                    self.isLogin = viewModel.getCurrentUser()
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
