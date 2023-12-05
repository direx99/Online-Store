//
//  LoginView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//


import SwiftUI
import Combine
import Firebase
import UIKit

struct LoginView: View {
    @State var userName = ""
    @State var email = ""
    @State var password = ""
    @State var isOn: Bool = false
    @State var isLoginMode = false
    @State private var showAlert = false
    @State private var isLoggedIn = false
    @State private var isPresented = false
    @State private var isLoggingIn = false
    @State private var showPassword: Bool = false
    @State private var isSignUpViewActive = false

    // Sign with Google on View
    @StateObject private var vm = SignWithGoogl()
    
    
    var shouldNavigateToHome: Bool {
        return isLoggedIn
    }
    
    
    init() {
        // Configure Firebase
        if (FirebaseApp.app() == nil) {
            FirebaseApp.configure()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
  
    
    var body: some View {
        NavigationStack {
           
            
            ZStack {
                NavigationLink(
                      destination: SignUpView(),
                      isActive: $isSignUpViewActive
                  ) {
                      EmptyView()
                  }
                  .hidden()
                  .navigationBarHidden(true)
                VStack {
                    Text("Welcome Back!")
                        .foregroundColor(Color("AppBlack"))
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .padding(.top, 30)
                    
                    Text("Please sign in to your account")
                        .foregroundColor(Color("TextGray"))
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .padding(-5)
                    VStack(spacing: 15) {
                        CustomTextField(email: $email, inputTitle: "Email")
                        CustomSecureField(password: $password, inputTitle: "Password")
                        
                        HStack {
                            Spacer()
                            Text("Forget Password?")
                                .foregroundColor(Color("TextGray"))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.vertical, 50)
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Button(action: {
                            handleAction()
                        }, label: {
                            VStack {
                                Text("Sign in")
                            }
                            .foregroundColor(Color.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color("AppBlue"))
                            .cornerRadius(20)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        })
                        
                        Button(action: {
                            vm.signGoogle()
                        }, label: {
                            HStack(spacing: 10) {
                                Image("google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                Text("Sign in with Google")
                            }
                            .foregroundColor(Color.black)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        })
                        
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(Color("AppBlack"))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Button(action: {
                                   isSignUpViewActive = true
                               }) {
                                   Text("Sign Up")
                                       .foregroundColor(Color("AppBlue"))
                                       .font(.system(size: 14))
                                       .fontWeight(.semibold)
                               }
                        }
                        .padding(.vertical)
                    }
                }
                .padding(30)
                .padding(.bottom, 30)
                .background(Color("BgColor"))
                
                
                
                
                NavigationLink(destination: HomeView(productViewModel: ClothProductViewModel(product: ClothProduct(name: "", brand: "", price: "", image: "", colors: [""], code: "")))
                    .navigationBarHidden(true)
                               , isActive: $vm.isLoginSuccessed) {
                    EmptyView()
                }
                
                               .hidden()
                NavigationLink(destination: HomeView(productViewModel: ClothProductViewModel(product: ClothProduct(name: "", brand: "", price: "", image: "", colors: [""], code: ""))), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                .hidden()
            }
            .navigationBarHidden(true)
            .onAppear {
                if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                    isLoggedIn = true
                }
                else if
                    UserDefaults.standard.bool(forKey: "isLoginSuccessed") {
                    vm.isLoginSuccessed = true
                }
            }
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            // Handle login mode actions if needed
        } else {
            loginUser()
        }
    }
    
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to sign in user: ", err)
                return
            }
            print("Successfully logged user \(result?.user.uid ?? "")")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoggedIn = true
                UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
                UserDefaults.standard.set(vm.isLoginSuccessed, forKey: "isLoginSuccessed")
                vm.isLoginSuccessed = true
                
                withAnimation {
                    isLoggingIn = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showAlert = true
                }
            }
        }
    }
    private func logout() {
        // Implement your logout logic here, e.g., sign out from Firebase
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            isLoggedIn = false
            UserDefaults.standard.set(false, forKey: "isLoginSuccessed")
            vm.isLoginSuccessed = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CustomTextField: View {
    @Binding var email: String
    var inputTitle: String = ""
    
    
    var body: some View{
        ZStack(alignment: .leading) {
            TextField("", text: $email)
                .foregroundColor(Color("AppBlack"))
                .padding(.horizontal,30)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .fontWeight(.semibold)
            
            
            if email.isEmpty {
                Text("\(inputTitle)")
                    .foregroundColor(Color.gray) // Change this color to the desired placeholder text color
                    .padding(.horizontal,30)
                    .allowsHitTesting(false)

                
                
            }
        }
        
    }
}

struct CustomSecureField: View {
    @Binding var password: String
    var inputTitle: String = ""
    @State var showPassword: Bool = false
    
    
    var body: some View{
        ZStack(alignment: .leading) {
            if showPassword != true {
                SecureField("", text: $password)
                    .foregroundColor(Color("AppBlack"))
                    .padding(.horizontal,30)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .fontWeight(.semibold)
            }
            else{
                TextField("", text: $password)
                    .foregroundColor(Color("AppBlack"))
                    .padding(.horizontal,30)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .fontWeight(.semibold)
            }
            
            
            
            
            if password.isEmpty {
                Text("\(inputTitle)")
                    .foregroundColor(Color.gray) // Change this color to the desired placeholder text color
                    .padding(.horizontal,30)
                    .allowsHitTesting(false)

                
            }
            HStack{
                Spacer()
                Button(action: {
                    showPassword.toggle()
                }, label:{
                    Image(systemName: showPassword ? "eye":"eye.slash")
                        .padding(.trailing,30)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 14))
                })
                
            }
            
            
            
        }
        
    }
}

