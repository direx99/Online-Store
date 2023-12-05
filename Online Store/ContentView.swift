//
//  ContentView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//

import SwiftUI
import GoogleSignIn

struct ContentView: View {
    

    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("isLoginSuccessed") var isLoginSuccessed: Bool = false

    


    var body: some View {
        VStack {
            
            
                if (isLoggedIn==true || isLoginSuccessed==true){
                    
                    HomeView(productViewModel: ClothProductViewModel(product: ClothProduct(name: "", brand: "", price: "", image: "", colors: [""], code: "")))
               
            }
            else{
                LoginView()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
        
    }
}
