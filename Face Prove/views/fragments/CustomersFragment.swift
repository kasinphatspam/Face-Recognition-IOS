//
//  CustomersView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 12/11/2566 BE.
//

import SwiftUI

struct CustomerListView: View {
    
    @StateObject var viewModel: CustomerListViewModel = CustomerListViewModel()
    @State private var contacts: [Contact]? = []
    
    var body: some View {
        VStack {
            VStack {
                if contacts != nil {
                    ForEach(contacts!) { contact in
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                CircleImage(image: contact.image ?? "")
                                    .padding(.leading)
                                VStack(alignment: .leading) {
                                    Text("\(contact.firstname) \(contact.lastname)")
                                        .font(.subheadline)
                                        .padding(.leading)
                                        .foregroundColor(.dynamicblack)
                                    Text("Tel. \(contact.mobile)")
                                        .font(.caption)
                                        .padding(.leading)
                                        .foregroundColor(.dynamicblack)
                                }
                                Spacer()
                                
                                if contact.encodedId == nil {
                                    Image(systemName: "faceid")
                                        .frame(width: 36, height: 36)
                                        .padding(.trailing)
                                        .foregroundColor(.red)
                                } else {
                                    Image(systemName: "faceid")
                                        .frame(width: 36, height: 36)
                                        .padding(.trailing)
                                        .foregroundColor(.blue)
                                }
            
                            }
                            .padding(.bottom, 12)
                        }
                    }
                }
                
            }
        }
        .onAppear() {
            Task {
                bindViewModel()
                try await viewModel.fetch()
            }
        }
    }
    
    func bindViewModel() {
        viewModel.contacts.bind { contacts in
            self.contacts = contacts
         }
    }
}


struct CustomersFragment: View {
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                CustomerListView()
                Spacer()
            }
            .padding(.leading,4)
            .padding(.trailing,4)
        }
    }
}

#Preview {
    CustomersFragment()
}
