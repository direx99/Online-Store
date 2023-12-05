//
//  SplashScreenView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        HStack(alignment: .bottom){
            Text("swift")
                .foregroundColor(Color.white)
                .font(.system(size: 40))
                .fontWeight(.bold)



            Text(".")
                .foregroundColor(Color("BgColor"))
                .font(.system(size: 80))
                .padding(.bottom,-10)
                .padding(.leading,-7)


        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color("AppBlue"))
        

            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
            .fullScreenCover(isPresented: $isActive) {
                ContentView() // Replace ContentView with your main app view
            }
    }
}


struct SpashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
