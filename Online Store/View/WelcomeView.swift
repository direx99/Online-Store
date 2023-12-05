//
//  WelcomeView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//


import SwiftUI

struct WelcomeView: View {
    
    @State private var isSigninViewEnable : Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                NavigationLink(
                    destination: LoginView(),
                    isActive: $isSigninViewEnable
                ) {
                    EmptyView()
                }
                .hidden()
                .navigationBarHidden(true)
                VStack{
                    Spacer()
                    HStack(alignment: .bottom){
                        Text("swift")
                            .foregroundColor(Color("AppBlack"))
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                        
                        
                        
                        Text(".")
                            .foregroundColor(Color("AppBlue"))
                            .font(.system(size: 80))
                            .padding(.bottom,-10)
                            .padding(.leading,-7)
                        
                        
                    }
                    .padding(.bottom,5)
                    
                    Text("Purchase premium clothes. You can buy it anytime and anywhere.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("AppBlack"))
                        .opacity(0.7)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                    
                    
                    Button(action: {
                        isSigninViewEnable = true
                        
                    }, label: {
                        VStack{
                            Text("Get Started")
                        }
                        .foregroundColor(Color.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color("AppBlue"))
                        .cornerRadius(20)
                        
                        
                        
                    })
                }
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .padding(30)
            .background(Color("BgColor"))
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
