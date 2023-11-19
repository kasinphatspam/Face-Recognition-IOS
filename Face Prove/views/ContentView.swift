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
    @State var isJoinOrg: Bool = false

    var body: some View {
        ZStack {
            if self.isActive && !isLogin {
                // login step
                NavigationView {
                    LoginActivity(isLogin: $isLogin)
                }
            } else if self.isActive && isLogin && !isJoinOrg {
                // join organization step
                NavigationView {
                    JoinOrganizationActivity(isJoinOrg: $isJoinOrg)
                }
            } else if self.isActive && isLogin && isJoinOrg {
                // launch main
                MainActivity()
            }
            else {
                // loading and checking step
                SplashActivity()
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetch()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                    let status = viewModel.getCurrentUser()
                    if status == -1 {
                        self.isLogin = false
                    }
                    
                    if status == 0 {
                        self.isLogin = true
                        self.isJoinOrg = false
                    }
                    
                    if status == 1 {
                        self.isLogin = true
                        self.isJoinOrg = true
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
