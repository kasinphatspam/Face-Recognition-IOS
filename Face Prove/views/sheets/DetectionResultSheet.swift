//
//  DetectionResultSheet.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 19/11/2566 BE.
//

import SwiftUI

struct DetectionResultSheet: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack() {
                ProfileCircleImage(image: UIImage(named: "mahiru")!)
                    .padding(.leading)
                VStack(alignment: .leading) {
                    Text("Kasinphat Ketchom").font(.headline).bold()
                    Text("Enterprise").font(.subheadline)
                }.padding(.leading)
                Spacer()
            }
            .padding(.top,32)
            
            Text("Contact Information")
                .font(.subheadline)
                .bold()
                .padding(.top)
                .padding(.leading)
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    Text("Email 1:")
                        .font(.caption)
                        .padding(.leading)
                    
                    Text("Tel:")
                        .font(.caption)
                        .padding(.leading)
                        .padding(.top,2)
                    
                    Text("Facebook:")
                        .font(.caption)
                        .padding(.leading)
                        .padding(.top,2)
                    Text("LinkedIn:")
                        .font(.caption)
                        .padding(.leading)
                        .padding(.top,2)
                }
                
                VStack(alignment: .leading) {
                    Text("Email 2: ")
                        .font(.caption)
                        .padding(.leading)
                    
                    Text("Office:")
                        .font(.caption)
                        .padding(.leading)
                        .padding(.top,2)
                    
                    Text("Line: ")
                        .font(.caption)
                        .padding(.leading)
                        .padding(.top,2)
                }
            }.padding(.top,2)
            
            Text("Other Information")
                .font(.subheadline)
                .bold()
                .padding(.top)
                .padding(.leading)
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    Text("Contact owner: ")
                        .font(.caption)
                        .padding(.leading)
                    
                    Text("Create At: ")
                        .font(.caption)
                        .padding(.leading)
                        .padding(.top,2)
                }
            }.padding(.top,2)
            
            Spacer()
        }
        .padding(.leading)
    }
}

#Preview {
    DetectionResultSheet()
}
