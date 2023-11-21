//
//  MainView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

struct BottomNavigationBar: View {
    
    @State private var tabTitle = "Dashboard"
    @State private var selection = 1
    @State private var searchText = ""
    @State private var visibility: Visibility = .visible
    @State private var searchOnClicked: Bool = false
    @Binding var shouldPopToRootView : Bool

    var body: some View {
        
        TabView(selection:$selection) {
            NavigationView {
                DashboardFragment(visibility: $visibility, searchOnClicked: $searchOnClicked)
                    .navigationTitle("Dashboard")
                    .toolbar(visibility, for: .tabBar)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Dashboard")
            }
            .tag(1)
            
            NavigationView {
                OrganizationFragment()
                    .navigationTitle("Organization")
            }
            .searchable(text: $searchText)
            .tabItem {
                Image(systemName: "tray.2.fill")
                Text("Organization")
            }
            .tag(2)
            
            NavigationView {
                CustomersFragment()
                    .navigationTitle("Customers")
            }
            .searchable(text: $searchText)
            .tabItem {
                Image(systemName: "person.3.sequence.fill")
                Text("Customers")
            }
            .tag(3)
            
            NavigationView {
                ProfileFragment(shouldPopToRootView: $shouldPopToRootView)
            }
            .tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Me")
            }
            .tag(4)
        }
        .onChange(of: searchOnClicked) {
            
            if searchOnClicked == true {
                selection = 3
                searchOnClicked = false
            }
        }
    }
}

struct MainActivity: View {
    
    @Binding var shouldPopToRootView : Bool
    
    var body: some View {
        BottomNavigationBar(shouldPopToRootView: $shouldPopToRootView)
    }
}


#Preview {
    MainActivity(shouldPopToRootView: .constant(false))
}
