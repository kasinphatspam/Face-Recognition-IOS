//
//  MainView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 11/11/2566 BE.
//

import SwiftUI

struct BottomNavigationBar: View {
    
    @Binding var tabTitle: String
    @Binding var selection: Int
    
    var body: some View {
        TabView(selection:$selection) {
            DashboardFragment()
                .onAppear {
                    self.tabTitle = "Dashboard"
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                .tag(1)
            OrganizationFragment()
                .onAppear {
                    self.tabTitle = "Organization"
                }
                .tabItem {
                    Image(systemName: "tray.2.fill")
                    Text("Organization")
                }
                .tag(2)
            CustomersFragment()
                .onAppear {
                    self.tabTitle = "Customers"
                }
                .tabItem {
                    Image(systemName: "person.3.sequence.fill")
                    Text("Customers")
                }
                .tag(3)
        }
    }
}

struct MainActivity: View {
    
    @State private var tabTitle = "Dashboard"
    @State private var selection = 1
    
    var body: some View {
        NavigationView {
            VStack() {
                Spacer()
                BottomNavigationBar(tabTitle: self.$tabTitle, selection: self.$selection)
                
            }
            .navigationBarTitle(Text(tabTitle))
            .navigationBarItems(
                trailing: CircleImage(image: UIImage(named: "mahiru")!)
            )
        }
    }
}

#Preview {
    MainActivity()
}
