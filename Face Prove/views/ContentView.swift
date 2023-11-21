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
    @State var shouldPopToRootView: Bool = false

    var body: some View {
        ZStack {
            if self.isActive && !isLogin {
                // login step
                NavigationView {
                    LoginActivity(isLogin: $isLogin, isJoinOrg: $isJoinOrg)
                }
            } else if self.isActive && isLogin && !isJoinOrg {
                // join organization step
                NavigationView {
                    JoinOrganizationActivity(isJoinOrg: $isJoinOrg, isLogin: $isLogin)
                }
            } else if self.isActive && isLogin && isJoinOrg {
                // launch main
                MainActivity(shouldPopToRootView: $shouldPopToRootView)
            }
            else {
                // loading and checking step
                SplashActivity()
            }
        }
        .onChange(of: shouldPopToRootView, { oldValue, newValue in
            if newValue == true {
                isLogin = false
                isJoinOrg = false
                isActive = true
            }
        })
        .onAppear {
            bindViewModel()
            Task {
                try await viewModel.getCurrentUser()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
    
    func bindViewModel() {
        viewModel.signal.bind { signal in
             guard let signal = signal else {
                 return
             }

             if signal.command == "USER_NOT_FOUND" {
                 isLogin = false
                 
             } else if signal.command == "USER_HAS_NOT_JOINED_ORGANIZATION" {
                 isLogin = true
                 isJoinOrg = false
             } else if signal.command == "USER_HAS_JOINED_ORGANIZATION" {
                 isLogin = true
                 isJoinOrg = true
             }
         }
    }
}

#Preview {
    ContentView()
}
