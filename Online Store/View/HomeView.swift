//
//  HomeView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//


import SwiftUI
import Firebase
import GoogleSignIn
import Foundation


struct HomeView: View {

    
        @State private var isProductDetailViewActive = false // Add a
    @ObservedObject var productViewModel: ClothProductViewModel // Assuming you want to use this to display products
    @State private var selectedProduct: ClothProductViewModel? // Add this state

    let products: [ClothProduct] = [
        ClothProduct(name: "VALENCIA TOP", brand: "Women Top", price: "59", image: "v1", colors: ["v3", "v2", "v1"], code : "v"),
        ClothProduct(name: "ELECTRA TOP", brand: "Women Top", price: "69", image: "e1", colors: ["v1", "v2", "v1"], code : "e")
        ]
    
    var body: some View {
        NavigationStack{
            
            VStack{
                
                HStack{
                    VStack(alignment:.leading){
                        HStack{
                            Text("Hi Dinith ")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                            Spacer()
                            NavigationLink(destination: CartView()) {
                                
                                Image(systemName: "cart")
                                    .font(.system(size: 24))
                                    .fontWeight(.bold)
                                    .padding(.trailing,-10)
                            }
                            NavigationLink(destination: AccountView()) {
                                
                                Image(systemName: "person.circle")
                                    .font(.system(size: 24))
                                    .fontWeight(.bold)
                                    .padding(.trailing,-10)
                            }
                            .padding(.leading)
                            
                            
                        }
                        .padding(.leading,10)
                        .padding(.top)
                        
                        Text("The best range of smart watches")
                            .font(.system(size: 14))
                            .padding(.leading,10)
                            .fontWeight(.light)
                            .opacity(0.7)
                            .padding(.bottom)
                        
                        VStack{
                            Coupen()
                                .padding(.bottom)
                            
                        }
                        .padding(.top,-10)
                        .padding(.trailing,-10)
                        
                        NavigationView {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(products) { product in
                                        NavigationLink(destination: ProductView(productViewModel: ClothProductViewModel(product: product))) {
                                            ProductCard(
                                                wimg: "\(product.code)1",
                                                name: product.name,
                                                brand: product.brand,
                                                price: product.price,
                                                colors: product.colors,
                                                code: product.code
                                            )
                                            
                                        }
                                    }
                                    .padding(.vertical, 20)
                                }
                                .background(Color("BgColor"))
                            }
                            .background(Color("BgColor"))
                            .padding(.trailing, -30)
                        }

                        
                        
                        
                    }

                    Spacer()

                }
                
                Spacer()


                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
            
            .padding(20)
            .background(Color("BgColor"))
            
            
            
        }
    }
}


struct SearchBar: View {
    
    @State var userName : String = ""
    
    var body: some View{
        HStack{
            HStack{
                
                HStack{
                    Image("SearchIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding(.leading,10)
                    TextField("Search", text: $userName)
                        .padding(.leading,5)
                        .font(.system(size: 14))
                        .foregroundColor(Color("AppGray"))
                    Spacer()
                    
                }
                
            }
            .frame(height: 40)
            
            .background(Color.white)
            
            .cornerRadius(80)
            
            Image("Filter")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
                .padding(.leading,10)
        }
        .padding(.top)
        
        
    }
}

struct ProductCard : View{
    @State  var wimg : String
    @State  var name : String
    @State  var brand : String
    @State  var price : String
    @State var colors : [String]
    @State var code : String
    
    
    var body: some View{
        VStack{
            HStack{
                Text("TRENDING ⚡️")
                    .foregroundColor(Color("AppBlue"))
                    .fontWeight(.bold)
                    .font(.system(size: 12))
                    .padding(.top,20)
                    .padding(.leading,20)
                    .padding(.bottom,10)
                
                
                Spacer()
                
            }
            Image("\(wimg)")
                .resizable()
                .scaledToFit()
                .padding(.vertical,-20)
            Spacer()
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text("\(name)")
                            .foregroundColor(Color("AppBlack"))
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .padding(.leading,30)
                        Spacer()
                        HStack(spacing:-7.5){
                            ForEach(colors, id: \.self) { colorName in
                                               ColorBtn(colorname: colorName)
                                           }
                            
                            
                        }
                        
                        .padding(.horizontal,10)
                    }
                    .padding(.bottom,-5)
                    .padding(.top,10)
                    Group{
                        Text("\(brand)")
                        
                        Text("8+ colors")
                            .font(.system(size: 12))
                            .padding(.top,-5)
                        
                        
                    }
                    .padding(.top,-5)
                    
                    .foregroundColor(Color("AppBlack"))
                    .font(.system(size: 15))
                    .padding(.leading,30)
                    HStack(alignment:.bottom){
                        Text("CAD \(price)")
                            .foregroundColor(Color("AppBlack"))
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.leading,30)
                            .padding(.top,5)
                        
                        
                        
                        
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color("AppBlue"))
                            .padding(.trailing,10)
                        
                        
                    }
                    
                }
                
                .padding(.bottom,20)
                
                
                
            }
            .padding(.top,20)
            
            
        }
        .frame(width: 240)
        .cornerRadius(20)
        .padding(.trailing,5)
        .padding(.top,10)
        .background(Color.white)
        .cornerRadius(20)

        
        
        
    }
}


struct Coupen : View {
    var body: some View{
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            Text("20% Off 🔥")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            Text("On your next purchase")
                                .font(.system(size: 14))
                        }
                        Spacer()
                        VStack(alignment: .trailing){
                            Text("CP2020")
                                .foregroundColor(.orange)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            Text("Redeem Code")
                                .font(.system(size: 12))
                                .opacity(0.7)
                            
                        }
                        .padding(.trailing,30)
                        
                    }
                    Spacer()
                    HStack{
                        Text("*Before July 31,2023")
                            .font(.system(size: 10))
                        Spacer()
                        HStack{
                            Text("REDEEM NOW")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                            
                        }
                        .padding(5)
                        .padding(.horizontal,10)
                        .background(Color.blue)
                        .cornerRadius(50)
                        .padding(.trailing,25)
                        .padding(.top,-5)
                        
                    }
                    
                    
                    
                }
                .padding(.vertical,15)
                
                Spacer()
            }
            .padding(.leading,35)
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.bottom,-70)
            HStack{
                VStack{
                    
                }
                .frame(width:35,height: 35)
                .background(Color("BgColor"))
                .cornerRadius(40)
                Spacer()
                
                VStack{
                    
                }
                .frame(width:35,height: 35)
                .background(Color("BgColor"))
                .cornerRadius(40)
                
                
            }
            .padding(.horizontal,-18)
            
            
            
        }
        
        .padding(.bottom,5)
        
        
        
    }
}


struct LogutView: View {
    
    var body: some View {
        ZStack {
            
            
            VStack{
                HomeHeader()
                Spacer()
                
            }
            
            // Your home screen content here
            
            Button(action: {
                // Perform logout action here
                logout()
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.red) // You can use your logout button style
                    .cornerRadius(20)
                    .padding(.horizontal, 30)
            }
        }
        .navigationBarHidden(true)
        
        .padding()
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color("BgColor"))
    }
    
    
    // Logout function
    private func logout() {
        // Implement your logout logic here, e.g., sign out from Firebase
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            UserDefaults.standard.set(false, forKey: "isLoginSuccessed")
            // Dismiss the current view (HomeView)
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}



struct HomeHeader: View {
    var body: some View{
        VStack{
            
            HStack{
                VStack(alignment: .leading){
                    Text("Welcome Back Diex99")
                        .foregroundColor(Color("AppBlack"))
                        .opacity(0.6)
                    Text("Let's Diclove new fashions")
                        .foregroundColor(Color("AppBlack"))
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                }
                Spacer()
            }
        }
    }
}

struct ColorBtn : View {
    @State var colorname : String = ""
    
    var body: some View{
        VStack{
            
        }
        .frame(width: 22,height: 22)
        .background(Color("\(colorname)"))
        .cornerRadius(40)
        .opacity(1)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(productViewModel: ClothProductViewModel(product: ClothProduct(name: "", brand: "", price: "", image: "", colors:[""], code: "")))
    }
}
