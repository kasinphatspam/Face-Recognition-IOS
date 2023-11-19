//
//  RealtimeDetectorActivity.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 18/11/2566 BE.
//

import SwiftUI

enum SheetAction {
    case cancel
    case nothing
}

struct RealtimeDetectorActivity: View {
    
    @State private var showResults = false
    @State private var settingsDetent = PresentationDetent.medium
    @State private var base64: String = ""
    
    // true: sheet is already showing
    // false: sheet is closed
    @State var sheetAction: SheetAction = SheetAction.nothing
    
    var body: some View {
        ZStack {
            CameraView(isDetected: $showResults, base64: $base64)
        }.sheet(isPresented: $showResults, onDismiss: {
            if sheetAction == .cancel {
                // dismissed using cancel button
                print("Cancel")
            }else if sheetAction == .nothing {
                // dismissed by swipe down
                print("Swipe down")
            }
        },content: {
            DetectionResultSheet().presentationDetents([.medium, .large])
        }).onChange(of: base64) { oldValue, newValue in
            if newValue != "" && newValue != oldValue {
                showResults = true
            }
        }
    }
}
