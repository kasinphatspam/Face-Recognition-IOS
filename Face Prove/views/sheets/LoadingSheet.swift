//
//  LoadingSheet.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 20/11/2566 BE.
//

import SwiftUI

struct LoadingSheet: View {
    
    @State private var showResults: Bool
    @State private var sheetAction: SheetAction = SheetAction.nothing
    
    init(showResults: <Bool>) {
        self.showResults = showResults.wrappedValue
    }
    
    var body: some View {
        VStack{}.sheet(isPresented: $showResults, onDismiss: {
            if sheetAction == .cancel {
                // dismissed using cancel button

            }else if sheetAction == .nothing {
                // dismissed by swipe down
                
            }
        },content: {
            ProgressView().presentationDetents([.medium, .large])
        })
        
    }
}
