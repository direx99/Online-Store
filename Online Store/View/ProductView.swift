//
//  ProductView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//

import SwiftUI
import Firebase

struct ProductView: View {
    
    @ObservedObject  var productViewModel : ClothProductViewModel

    let transition = AnyTransition.asymmetric(insertion: .slide, removal: .scale).combined(with: .opacity)
    let transition2 = AnyTransition.asymmetric(insertion: .slide, removal: .slide).combined(with: .opacity)
    
    @State private var activeWatch : Int = 1
    @State private var activeImage : String = "v1"
    
    @State private var cart : Bool = false
    
    
    
    var body: some View {
        VStack{
            
            VStack{
                
            }
            .frame(width: 300,height: 70)
            .background(Color("LightGray"))
            
            VStack{
                
            }
            .frame(width: 300,height: 200)
            .background(Color("LightGray"))
            .cornerRadius(100)
            .padding(.top,-100)
            
            VStack{
                
                if(activeWatch == 1){
                    Image("\(productViewModel.product.code)1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320,height: 320)
                        .padding(.top,50)
                        .transition(transition2)
                    
                    
                    
                    
                }
                else  if(activeWatch == 2){
                    Image("\(productViewModel.product.code)2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320,height: 320)
                        .padding(.top,50)
                        .transition(transition2)
                    
                    
                }
                else  if(activeWatch == 3){
                    Image("\(productViewModel.product.code)3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320,height: 320)
                        .padding(.top,50)
                        .transition(transition2)
                    
                    
                }
                
                
                
                
                
                
                
                
                
            }
            .transition(transition2)
            .animation(.default.speed(0.7))
            
            .padding(.top,-240)
            VStack{
                HStack{
                    Text(productViewModel.product.name)
                        .font(.system(size: 24))
                        .foregroundColor(Color("AppBlack"))
                        .fontWeight(.semibold)
                    Text("By FOA")
                        .foregroundColor(Color("AppBlack"))
                        .font(.system(size: 24))
                        .opacity(0.3)
                        .fontWeight(.medium)
                    Spacer()
                    
                    
                    
                }
                HStack{
                    Text("Experience the epitome of comfort and elegance with our Valencia Set.")
                        .padding(.top,-10)
                        .font(.system(size: 14))
                        .opacity(0.7)
                        .fontWeight(.regular)
                    
                    Spacer()
                }
                HStack(alignment:.bottom){
                    Text("Available Colors")
                        .foregroundColor(Color("AppBlack"))
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    Spacer()
                    Text("Available Sizes")
                        .foregroundColor(Color("AppBlack"))
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    
                    
                    
                    
                    
                    
                }
                .padding(.top)
                HStack(spacing: 5) {
                    ForEach(1 ..< 4) { index in
                        let colorName = "\(productViewModel.product.code)\(index)"
                        Button(action: {
                            activeWatch = index
                            activeImage = colorName
                            print(activeImage)
                        }) {
                            ColorBtn(colorname: colorName)
                        }
                    }
                    Spacer()
                    HStack{
                        SizeCard(size: "S")
                        SizeCard(size: "M")
                        SizeCard(size: "L")
                        SizeCard(size: "XL")


                    }
                }
                
                HStack{
                    Text("Experience the epitome of comfort and elegance with our Valencia Set. This soft ribbed ensemble, consisting of a top and leggings, is not just active-wear; it's a luxurious embrace that flatters and elevates your every move.")
                    
                        .foregroundColor(Color("AppGray"))
                        .font(.system(size: 14))
                    +
                    Text(" Read More")
                        .foregroundColor(.blue)
                        .font(.system(size: 14))
                    Spacer()
                }
                .padding(.top)
                HStack(alignment: .bottom){
                    Text("CAD \(productViewModel.product.price)")
                        .foregroundColor(Color("AppBlack"))
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                    Text(" + Free shipping")
                        .foregroundColor(Color("AppBlack"))
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .opacity(0.5)
                        .padding(.bottom,3)
                    Spacer()
                    
                }
                .padding(.top)
                
            }
            .padding(20)
            
            Spacer()
            
            HStack{
                Button(action: {
                    // Code to execute when the button is tapped
                    
                }) {
                    
                    if cart == true{
                        Image("d")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        
                    }
                    else{
                        Image("ca")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .font(.system(size: 20))
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    }
                }
                if (cart == true){
                    Button(action: {
                        // Code to execute when the button is tapped
                        cart = false
                    }
                           
                    ) {
                        
                        Text("Cart Added Sucessfully")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(width: 300)
                            .background(Color.blue)
                            .cornerRadius(100)
                        
                    }
                }
                else {
                    Button(action: {
                       
                        cart = true
                        // Send data to Firestore
                        let db = Firestore.firestore()
                        let filmCollection = db.collection("cart")
                        filmCollection.addDocument(data: [
                            "name": productViewModel.product.name,
                            "price": productViewModel.product.price,
                            "color": activeImage,
                            "image": activeImage


                        ]) { error in
                            if let error = error {
                                print("Error adding document: \(error)")
                            } else {
//                                Alert(title: Text("dpne"))
                                print("Document added to Firestore with automatically generated ID")
                            }
                        }
                    }) {
                        
                        Text("Add to cart")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(width: 300)
                            .background(Color.blue)
                            .cornerRadius(100)
                        
                    }
                }
            }
            
            .animation(.default.speed(0.7))
            
            
            
        }
        
        
        .toolbar(.hidden, for: .tabBar)
        
        
    }
    
}

struct ProductView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProductView(productViewModel: ClothProductViewModel(product: ClothProduct(name: "", brand: "", price: "", image: "", colors: [""], code: "")))
    }
}

struct SizeCard : View {
    var size : String
    var body: some View{
        VStack{
            Text("\(size)")
                .font(.system(size: 10))
        }
        .frame(width: 22,height: 22)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.blue, lineWidth: 2)
        )
        
        
    }
}


