//
//  OrganizationView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 12/11/2566 BE.
//

import SwiftUI

struct OrganizationPasscodeView: View {
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
                    Text("Your organization passcode is **ADSDFS**")
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
    }
}

struct AdminListView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Admin").font(.headline).padding(.leading)
                Spacer()
            }.padding(.top, 8)
            
            VStack {
                ForEach(0 ..< 2) { value in
                    
                    HStack {
                        CircleImage(image: UIImage(named: "mahiru")!).padding(.leading)
                        VStack(alignment: .leading) {
                            Text("Kasinphat Ketchom").font(.subheadline).padding(.leading)
                            Text("Tel. 0653246900").font(.caption).padding(.leading)
                        }
                        Spacer()
                    }.padding(.bottom, 12)
                }
                
            }
        }
    }
}

struct EmployeeListView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Employee").font(.headline).padding(.leading)
                Spacer()
            }.padding(.top, 8)
            
            VStack {
                ForEach(0 ..< 10) { value in
                    
                    HStack {
                        CircleImage(image: UIImage(named: "mahiru")!).padding(.leading)
                        VStack(alignment: .leading) {
                            Text("Kasinphat Ketchom").font(.subheadline).padding(.leading)
                            Text("Tel. 0653246900").font(.caption).padding(.leading)
                        }
                        Spacer()
                    }.padding(.bottom, 12)
                }
                
            }
        }
    }
}


struct OrganizationFragment: View {
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                OrganizationPasscodeView().padding(.top)
                Divider().padding(.top).padding(.leading).padding(.trailing)
                AdminListView()
                Divider().padding(.top).padding(.leading).padding(.trailing)
                EmployeeListView()
                Divider().padding(.top).padding(.leading).padding(.trailing)
                Spacer()
            }
        }
    }
}

#Preview {
    OrganizationFragment()
}
