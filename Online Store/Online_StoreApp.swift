//
//  Online_StoreApp.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct Online_StoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{


func application(_ application:UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey:
                                                Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
    
}
@available(iOS 9.0, *)

func application(_ application:UIApplication, open url: URL,optios:
                 [UIApplication.OpenURLOptionsKey:Any] = [:]) -> Bool{
    return GIDSignIn.sharedInstance.handle(url)
    
}

}
