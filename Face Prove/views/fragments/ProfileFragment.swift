//
//  ProfileFragment.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 13/11/2566 BE.
//

import SwiftUI

struct HeaderInformationView: View {
    var body: some View {
        HStack {
            ProfileCircleImage(image: UIImage(named: "mahiru")!).padding(.leading).padding(.top).padding(.bottom)
            VStack(alignment: .leading) {
                Text("Kasinphat Ketchom").font(.title3).bold()
                Text(verbatim: "kasinphat@gmail.com").foregroundColor(.gray)
            }.padding(.top)
                .padding(.leading)
                .padding(.bottom)
            Spacer()
        }.padding(.top).padding(.leading)
    }
}

struct InformationView: View {
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
            
            Section(header: Text("Organization")) {
                RowNegativeView(iconName:"door.left.hand.open", text:"Leave an organization")
            }
            
            Section(header: Text("History")) {
                ForEach(0 ..< 30) { value in
                    HStack {
                        CircleImage(image: UIImage(named: "mahiru")!)
                        VStack(alignment: .leading) {
                            Text("Kasinphat Ketchom").font(.subheadline).padding(.leading)
                            Text("Detected at Monday 20:30 AM").font(.caption).padding(.leading)
                        }
                        Spacer()
                    }
                }
            }
        }
        
    }
}

struct ProfileFragment: View {
    
    var body: some View {
        
        VStack {
            HeaderInformationView()
            InformationView()
            Spacer()
        }
    }
}

#Preview {
    ProfileFragment()
}
