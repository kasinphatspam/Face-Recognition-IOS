//
//  RowView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 13/11/2566 BE.
//

import SwiftUI

struct RowView: View {
    var iconName: String
    var text: String
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: iconName).foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(text)
            }
        }
    }
}

struct RowNegativeView: View {
    var iconName: String
    var text: String
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: iconName).foregroundColor(.red)
            VStack(alignment: .leading) {
                Text(text).foregroundColor(.red)
            }
        }
    }
}

#Preview {
    RowView(iconName: "key.viewfinder", text: "mahiru")
}
