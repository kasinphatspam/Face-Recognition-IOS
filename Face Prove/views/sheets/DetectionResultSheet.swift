//
//  DetectionResultSheet.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 19/11/2566 BE.
//

import SwiftUI

struct DetectionResultSheet: View {
    
    private var contact: Contact? = nil
    
    init(contact: Contact? = nil) {
        self.contact = contact
    }
    
    var body: some View {
        
        if contact != nil {
            VStack(alignment: .leading) {
                
                HStack() {
                    ProfileCircleImage(image: contact?.image ?? "")
                        .padding(.leading)
                    VStack(alignment: .leading) {
                        Text("\(contact!.firstname) \(contact!.lastname)")
                            .font(.headline)
                            .bold()
                        Text(contact!.company ?? "").font(.subheadline)
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
                        Text("Email 1: \(contact!.email1)")
                            .font(.caption)
                            .padding(.leading)
                        
                        Text("Tel: \(contact!.mobile)")
                            .font(.caption)
                            .padding(.leading)
                            .padding(.top,2)
                        
                        Text("Facebook: \(contact!.facebook ?? "")")
                            .font(.caption)
                            .padding(.leading)
                            .padding(.top,2)
                        Text("LinkedIn: \(contact!.linkedin ?? "")")
                            .font(.caption)
                            .padding(.leading)
                            .padding(.top,2)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Email 2: \(contact!.email2 ?? "")")
                            .font(.caption)
                            .padding(.leading)
                        
                        Text("Office: \(contact!.officePhone ?? "")")
                            .font(.caption)
                            .padding(.leading)
                            .padding(.top,2)
                        
                        Text("Line: \(contact!.lineId ?? "")")
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
                        Text("Contact owner: \(contact!.owner ?? "")")
                            .font(.caption)
                            .padding(.leading)
                        
                        Text("Create At: \(contact!.createdTime)")
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
}

#Preview {
    DetectionResultSheet(contact: nil)
}
