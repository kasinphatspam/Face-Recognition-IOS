//
//  LoginView.swift
//  Face Prove
//
//  Created by Kasinphat Ketchom on 8/11/2566 BE.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct NavBar_Replacement: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0 ..< 15) { item in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.orange)
                        .frame(height: 44)
                        .padding()
                }
            }
            .safeAreaInset(edge: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack() {
                        Text("Custom Nav Bar")
                            .font(.largeTitle.weight(.bold))
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "wifi")
                        }
                    }
                    Text("With safeAreaInset you can create your own custom nav bar.")
                        .font(.caption)
                }
                .padding()
                .background(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                .overlay(.ultraThinMaterial)
                )
            }
            .navigationBarHidden(true)
            .tint(.orange)
        }
    }
}

struct LoginActivity: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State private var isLogin: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPresentingAlert: Bool = false
    @State private var alertText: String = "Username or password you entered incorrect."
    @State private var showResults = false
    @State var sheetAction: SheetAction = SheetAction.nothing
    @FocusState var isFocus: Bool
    
    var body: some View {
        
        if self.isLogin {
            NavigationView {
                JoinOrganizationActivity()
            }
        } else {
            
            NavigationView {
                
                ZStack {
                    Color(.systemGray6).ignoresSafeArea()
                    Form {
                        Section(header: Text("Introduce your credentials")) {
                            TextField("Email address", text: $email).autocapitalization(.none).focused($isFocus)
                            SecureField("Password", text: $password).autocapitalization(.none).focused($isFocus)
                        }
                        
                        Button("Continue") {
                            isFocus = false
                            if !email.isEmpty && !password.isEmpty{
                                self.showResults = true
                                Task {
                                    try await viewModel.login(email: email, password: password)
                                }
                            } else {
                                alertText = "Please fill out email and password field."
                                isPresentingAlert = true
                            }
                        }.alert(alertText,
                                isPresented: $isPresentingAlert) {
                        }.sheet(isPresented: $showResults, onDismiss: {
                            if sheetAction == .cancel {
                                // dismissed using cancel button
                                print("Cancel")
                            }else if sheetAction == .nothing {
                                // dismissed by swipe down
                                print("Swipe down")
                            }
                        },content: {
                            ProgressView().presentationDetents([.medium, .large])
                        })
                        
                        Section(header: Text("other services")) {
                            Button("Forgot your password") {
                                
                            }
                            
                            NavigationLink(destination: RegisterActivity()) {
                                Button("Create a new account") {
                                    
                                }
                            }
                            
                        }
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            VStack(alignment: .leading) {
                                Text("Face Prove").font(.subheadline)
                            }
                        }
                    }
                    .navigationTitle("Welcome Back!")
                    .navigationBarTitleDisplayMode(.large)
                    .onAppear() {
                        bindViewModel()
                    }
                    
                }
            }
        }
        
    }
    
    func bindViewModel() {
        viewModel.signal.bind { signal in
            showResults = false
             guard let signal = signal else {
                 return
             }

             if signal.command == "AUTH_LOGIN_COMPLETED" {
                 self.isLogin = true
                 
             } else if signal.command == "AUTH_LOGIN_FAILED" {
                 self.alertText = "Username or password you entered incorrect."
                 self.isPresentingAlert = true
             }

         }        
    }
    
}

#Preview {
    LoginActivity()
}
