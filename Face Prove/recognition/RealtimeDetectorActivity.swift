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
    
    @State private var maxIndex = 0
    @State private var currentIndex = 0
    @State private var contacts: [Contact] = []
    @State private var showResults = false
    @State private var showUnknown = false
    @State private var showLoading = false
    @State private var showLostConnect = false
    @State private var settingsDetent = PresentationDetent.medium
    @State private var base64: String = ""
    @State private var isContinue: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: RealtimeDetectorViewModel = RealtimeDetectorViewModel()
    
    // true: sheet is already showing
    // false: sheet is closed
    @State var sheetAction: SheetAction = SheetAction.nothing
    
    var body: some View {
        VStack {
            CameraView(isDetected: $showResults, isContinue: $isContinue, base64: $base64)
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    if showLoading {
                        ProgressView().padding()
                    } else {
                        ProgressView().padding().hidden()
                    }
                }
            }.frame(height: 80)
        }
        .sheet(isPresented: $showLostConnect, content: {
            VStack {
                Text("Lost connect to the server").bold()
                Text("Please try again later").font(.caption)
            }
            .onDisappear() {
                showLostConnect = false
                self.presentationMode.wrappedValue.dismiss()
            }
            .presentationDetents([.height(200)])
        })
        .sheet(isPresented: $showUnknown, onDismiss: {
            if sheetAction == .cancel {
                // dismissed using cancel button
                print("Cancel")
            }else if sheetAction == .nothing {
                // dismissed by swipe down
                print("Swipe down")
                isContinue = true
                isContinue = false
            }
        },content: {
            VStack {
                Text("Unknown").bold()
                Text("Please try again or you can type").font(.caption)
                Text("a customer's name to search for information").font(.caption)
            }
            .presentationDetents([.medium, .large])
        })
        .sheet(isPresented: $showResults, onDismiss: {
            if sheetAction == .cancel {
                // dismissed using cancel button
                print("Cancel")
            }else if sheetAction == .nothing {
                // dismissed by swipe down
                print("Swipe down")
            }
        },content: {
            ScrollView {
                ForEach(contacts) { contact in
                    DetectionResultSheet(contact: contact)
                        
                }
            }.presentationDetents([.medium, .large])
        })
        .onChange(of: base64) { oldValue, newValue in
            if newValue != "" && newValue != oldValue {
                showLoading = true
                Task {
                    try await viewModel.reconize(image: newValue)
                }
            }
        }
        .onAppear() {
            bindViewModel()
        }
    }
    func bindViewModel() {
        viewModel.signal.bind { signal in
            showLoading = false
            showResults = false
            showUnknown = false
            showLostConnect = false
             guard let signal = signal else {
                 return
             }

             if signal.command == "RECOGNITION_NOT_FOUND_FACE" {
                 isContinue = true
                 isContinue = false
                 
             } else if signal.command == "RECOGNITION_UNKNOWN" {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                     withAnimation {
                         showUnknown = true
                     }
                 }
                 
             } else if signal.command == "RECOGNITION_COMPLETED" {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                     withAnimation {
                         showResults = true
                     }
                 }
             } else if signal.command == "RECOGNITION_CANNOT_CONNECT_TO_SERVER" {
                 showLostConnect = true
             }
         }
        
        viewModel.result.bind { index in
            
            guard let index = index else {
                return
            }
            
            if index.result != nil {
                maxIndex = index.result!.count
                contacts = index.result!
            }
        }
    }
}

//#Preview {
//    RealtimeDetectorActivity()
//}
