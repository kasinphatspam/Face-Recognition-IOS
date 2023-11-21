//
//  DashboardView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 12/11/2566 BE.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Realtime recognize is available").font(.subheadline).padding(.leading)
            }
            Spacer()
        }
    }
}

struct OrganizationDetailsView: View {
    var body: some View {
        VStack {
            
            HStack {
                Text("Orgnaization Details").font(.headline).padding(.leading)
                Spacer()
                Text("View employee").font(.caption).padding(.trailing)
            }
            
            OrganizationPasscodeView()
            
        }
    }
}

struct TaskSummaryView: View {
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                VStack {
                    Text("DETECT").foregroundColor(.white).font(.caption)
                    Text("0").bold().foregroundColor(.white)
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                .background(.darkgray)
                .cornerRadius(8)
                .padding(.leading)
                
                VStack {
                    Text("ONLINE").foregroundColor(.white).font(.caption)
                    Text("0").bold().foregroundColor(.white)
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                .background(.darkgray)
                .cornerRadius(8)
                
                VStack {
                    Text("REQUEST").foregroundColor(.white).font(.caption)
                    Text("0").bold().foregroundColor(.white)
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 60)
                .background(.darkgray)
                .cornerRadius(8)
                
            }
        }
    }
}


struct RecognizeChoiceView: View {
    
    @Binding var visibility: Visibility
    @Binding var searchOnClicked: Bool
    
    var body: some View {
        HStack {
            Text("Search customer information").font(.headline).padding(.leading)
            Spacer()
        }.padding(.top)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                
                Button("Search by text") {
                    searchOnClicked = true
                }.buttonStyle(GrowingButton(color: .darkpurple))
                    .padding(.leading)
                
                NavigationLink {
                    RealtimeDetectorActivity()
                        .navigationTitle("Face Detector")
                        .toolbarTitleDisplayMode(.inline)
                        .onAppear() {
                            visibility = .hidden
                        }
                        .onDisappear() {
                            visibility = .visible
                        }
                } label: {
                    Text("Realtime recognize")
                }.buttonStyle(GrowingButton(color: .pinkred))
            }
        }
    }
}

struct LatestDetectView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Today").font(.headline).padding(.leading)
                Spacer()
                Text("View history").font(.caption).padding(.trailing)
            }.padding(.top, 8)
            
            VStack {
                ForEach(0 ..< 10) { value in
                    
                    HStack {
                        CircleImage(image: "").padding(.leading)
                        VStack(alignment: .leading) {
                            Text("Kasinphat Ketchom").font(.subheadline).padding(.leading)
                            Text("Detected at Monday 20:30 AM").font(.caption).padding(.leading)
                        }
                        Spacer()
                    }.padding(.bottom, 12)
                }
                
            }
        }
    }
}

struct DashboardFragment: View {
    
    @Binding var visibility: Visibility
    @Binding var searchOnClicked: Bool
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                HeaderView()
                Divider().padding(.top).padding(.leading).padding(.trailing)
                OrganizationDetailsView().padding(.top,8)
                TaskSummaryView().padding(.top,8)
                Divider().padding(.top).padding(.leading).padding(.trailing)
                RecognizeChoiceView(visibility: $visibility, searchOnClicked: $searchOnClicked)
                Divider().padding(.top).padding(.leading).padding(.trailing)
                LatestDetectView()
                Divider().padding(.top).padding(.leading).padding(.trailing)
                Spacer()
            }
            .padding(.leading,4)
            .padding(.trailing,4)
        }
    }
}

#Preview {
    DashboardFragment(visibility: .constant(.visible), searchOnClicked: .constant(false))
}
