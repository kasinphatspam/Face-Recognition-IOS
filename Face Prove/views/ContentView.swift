//
//  ContentView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView()){
                    Text("Press")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
