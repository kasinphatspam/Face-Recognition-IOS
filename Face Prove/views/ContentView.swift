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
            HStack {
                Text("None")
                    .bold()
            }
            .navigationTitle("Employee")
            .onAppear {
                
                Task {
                    do {
                        try await viewModel.login()
                        try await viewModel.fetch()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
