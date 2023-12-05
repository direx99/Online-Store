//
//  SignWithGoogle.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//


import Foundation
import Firebase
import SwiftUI
import GoogleSignIn

class SignWithGoogl: ObservableObject{
    @Published var isLoginSuccessed = false
    @State private var isLoggedIn = false
    
    
    func signGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {return}
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration =  config
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: Application_utility.rootViewController){
                user, error in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                guard
                    let user = user?.user,
                    let idToken = user.idToken else { return }
                
                let accessToken = user.accessToken
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                
                Auth.auth().signIn(with: credential){ res, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
                if let user = Auth.auth().currentUser {
                    // Print the user's email
                    print("User email: \(user.email ?? "N/A")")
                    // Set the login success flag
                    self.isLoginSuccessed = true
                    UserDefaults.standard.set(self.isLoginSuccessed, forKey: "isLoginSuccessed")
                }
                
            }
    }
}
