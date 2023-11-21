//
//  ProfileFragment.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 13/11/2566 BE.
//

import SwiftUI

struct HeaderInformationView: View {
    
    @StateObject var viewModel: HeaderInformationViewModel = HeaderInformationViewModel()
    @State private var user: User? = nil
    
    var body: some View {
        HStack {
            ProfileCircleImage(image: user?.image ?? "").padding(.leading).padding(.top).padding(.bottom)
            VStack(alignment: .leading) {
                Text("\(user?.firstname ?? "") \(user?.lastname ?? "")" ).font(.title3).bold()
                Text(verbatim: "\(user?.email ?? "")").foregroundColor(.gray)
            }.padding(.top)
                .padding(.leading)
                .padding(.bottom)
            Spacer()
        }
        .padding(.top).padding(.leading)
        .onAppear() {
            user = viewModel.fetch()
        }
    }
}

struct InformationView: View {
    
    @StateObject var viewModel: InformationViewModel = InformationViewModel()
    @Binding var shouldPopToRootView : Bool
    @State private var isPresentingLogoutConfirm: Bool = false
    @State private var isPresentingLeaveConfirm: Bool = false
    
    var body: some View {
            
        Form {
            Section(header: Text("Profile")) {
                NavigationLink(destination: EditProfileActivity()) {
                    RowView(iconName:"person.text.rectangle.fill", text:"Personal Information")
                }
                NavigationLink(destination: ChangePasswordActivity()) {
                    RowView(iconName:"key.viewfinder", text: "Change password")
                }
                NavigationLink(destination: EditProfileActivity()) {
                    RowView(iconName:"creditcard.fill", text:"Payment")
                }
                
            }
            
            Section(header: Text("Account & Organization")) {
                
                Button (action: {
                    isPresentingLeaveConfirm = true
                }) {
                    RowNegativeView(iconName:"door.left.hand.open", text:"Leave an organization")
                }
                
                Button (action: {
                    isPresentingLogoutConfirm = true
                }) {
                    RowNegativeView(iconName:"door.left.hand.open", text:"Logout")
                }
            }
            
            Section(header: Text("History")) {
                ForEach(0 ..< 30) { value in
                    HStack {
                        CircleImage(image: "")
                        VStack(alignment: .leading) {
                            Text("Kasinphat Ketchom").font(.subheadline).padding(.leading)
                            Text("Detected at Monday 20:30 AM").font(.caption).padding(.leading)
                        }
                        Spacer()
                    }
                }
            }
            
        }
        .confirmationDialog("Are you sure?",
             isPresented: $isPresentingLeaveConfirm) {
             Button("Leave an organization ?", role: .destructive) {
                 
              }
            }
        .confirmationDialog("Are you sure?",
             isPresented: $isPresentingLogoutConfirm) {
             Button("Logout ?", role: .destructive) {
                 viewModel.logout()
                 self.shouldPopToRootView = true
              }
            }
        
    }
}

struct ProfileFragment: View {
    
    @Binding var shouldPopToRootView : Bool
    
    var body: some View {
        
        VStack {
            HeaderInformationView()
            InformationView(shouldPopToRootView: $shouldPopToRootView)
            Spacer()
        }
        .padding(.leading,4)
        .padding(.trailing,4)
    }
}

#Preview {
    ProfileFragment(shouldPopToRootView: .constant(false))
}
