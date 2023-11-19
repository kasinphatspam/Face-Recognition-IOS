//
//  CustomersView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 12/11/2566 BE.
//

import SwiftUI

struct CustomerListView: View {
    
    var body: some View {
        VStack {
            VStack {
                ForEach(0 ..< 14) { value in
                    
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


struct CustomersFragment: View {
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                CustomerListView().padding(.top)
                Divider().padding(.top).padding(.leading).padding(.trailing)
                Spacer()
            }
        }
    }
}

#Preview {
    CustomersFragment()
}
