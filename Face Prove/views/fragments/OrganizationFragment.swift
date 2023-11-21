//
//  OrganizationView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 12/11/2566 BE.
//

import SwiftUI

struct OrganizationPasscodeView: View {
    
    @StateObject var viewModel: OrganizationPasscodeViewModel = OrganizationPasscodeViewModel()
    @State private var organization: Organization? = nil
    
    var body: some View {
            
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(.darkgray)
            
            VStack {
                HStack {
                    Text("KMUTT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                    
                    Spacer()
                }
                
                HStack {
                    Text("Your organization passcode is **\(organization?.passcode ?? "")**")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Spacer()
                }
            
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .onAppear() {
            Task {
                organization = viewModel.fetch()
            }
        }
    }
}

struct EmployeeListView: View {
    
    @StateObject var viewModel: EmployeeListViewModel = EmployeeListViewModel()
    @State private var users: [User]? = []
    
    var body: some View {
        VStack {
            HStack {
                Text("Employee").font(.headline).padding(.leading)
                Spacer()
            }.padding(.top, 8)
            
            VStack {
                if users != nil {
                    ForEach(users!) { user in
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                CircleImage(image: user.image ?? "")
                                    .padding(.leading)
                                VStack(alignment: .leading) {
                                    Text("\(user.firstname) \(user.lastname)")
                                        .font(.subheadline)
                                        .padding(.leading)
                                        .foregroundColor(.dynamicblack)
                                    Text("\(user.email)")
                                        .font(.caption)
                                        .padding(.leading)
                                        .foregroundColor(.dynamicblack)
                                }
                                Spacer()
                                
                                if user.role?.name == "administrator" {
                                    Image(systemName: "star.square.fill")
                                        .frame(width: 36, height: 36)
                                        .padding(.trailing)
                                        .imageScale(.large)
                                        .foregroundColor(.blue)
                                    
                                }
                            }.padding(.bottom, 12)
                        }
                    }
                }
            }
        }
        .onAppear() {
            bindViewModel()
            Task {
                try await viewModel.fetch()
            }
        }
    }
    func bindViewModel() {
        viewModel.users.bind { users in
            self.users = users
         }
    }
}


struct OrganizationFragment: View {
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                OrganizationPasscodeView()
                Divider().padding(.top).padding(.leading).padding(.trailing)
                EmployeeListView()
                Spacer()
            }
            .padding(.leading,4)
            .padding(.trailing,4)
        }
    }
}

#Preview {
    OrganizationFragment()
}
