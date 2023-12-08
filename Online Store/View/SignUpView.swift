//
//  SignUpView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//


import SwiftUI
import Combine
import Firebase
import UIKit

struct SignUpView: View {
    @State var userName = ""
    @State var email = ""
    @State var name = ""
    @State var phone = ""
    @State var password = ""
    @State var isOn: Bool = false
    @State var isLoginMode = false
    @State private var showAlert = false
    @State private var isLoggedIn = false
    @State private var isPresented = false
    @State private var isLoggingIn = false
    @State private var isLoginViewActive = false
    
    
    @State var showPassword : Bool = false
    @StateObject private var vm = SignWithGoogl()
    init(accountViewModel: AccountViewModel = AccountViewModel()) {
        self.accountViewModel = accountViewModel
        
        // configure firebase
        if(FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
    }
    
    @ObservedObject  var accountViewModel : AccountViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                NavigationLink(
                    destination: LoginView(),
                    isActive: $isLoginViewActive
                ) {
                    EmptyView()
                }
                .hidden()
                .navigationBarHidden(true)
                VStack{
                    
                    Text("Create new account")
                        .foregroundColor(Color("AppBlack"))
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .padding(.top,30)
                    
                    Text("Please fill in the form to continue")
                        .foregroundColor(Color("AppGray"))
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .padding(-10)
                    VStack(spacing:15){
                        CustomTextField(email: $name,inputTitle:"Full Name")
                        CustomTextField(email: $email,inputTitle:"Email Address")
                        CustomTextField(email: $phone,inputTitle:"Phone Number")
                        CustomSecureField(password: $password,inputTitle:"Password")
                    }
                    .padding(.vertical,50)
                    
                    Spacer()
                    
                    
                    
                    
                    VStack(spacing:10){
                        Button(action: {
                            handleAction()
                        }, label: {
                            VStack{
                                Text("Sign Up")
                            }
                            .foregroundColor(Color.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color("AppBlue"))
                            .cornerRadius(20)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                        })
                        
                        
                        HStack{
                            Text("Have an account?")                        .foregroundColor(Color("AppBlack"))
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            Button(action: {
                                isLoginViewActive = true
                            }) {
                                Text("Login")
                                    .foregroundColor(Color("AppBlue"))
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                            }
                            
                            
                        }
                        .padding(.vertical)
                    }
                    
                }
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .padding(30)
            .padding(.bottom,30)
            .background(Color("BgColor"))
        }
    }
    private func handleAction() {
        if isLoginMode {
            print("Should log into Firebase with existing credentials")
        } else {
            createNewAccount()
        }
    }
    
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: email, password: password){
            result, err in
            if let err = err {
                print("failed to create user: ", err)
                return
            }
            
            
            // Send data to Firestore
            let db = Firestore.firestore()
            let filmCollection = db.collection("account")
            filmCollection.addDocument(data: [
                "name": name,
                "email": email,
                "phone": phone
                
            ]) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added to Firestore with automatically generated ID")
                }
            }
            
            print("Successfully created user \(result?.user.uid ?? "")")
            showAlert = true
            email = ""
            password = ""
            phone = ""
            name = ""
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}







