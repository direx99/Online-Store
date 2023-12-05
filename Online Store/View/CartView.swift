//
//  CartView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel = CartViewModel()
    
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading){
                HStack{
                    Text("Cart")
                        .font(.system(size: 30)).fontWeight(.semibold)
                        .foregroundColor(Color("AppBlack"))
                    Spacer()
                }
                
                List(viewModel.cart) { film in
                    
                    
                    VStack{
                        HStack(alignment:.top){
                            Image("\(film.image)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(film.name) FOA Cloathimnhg")
                                    .font(.system(size: 14)).fontWeight(.semibold)
                                HStack{
                                    Text("Size M & Color")
                                    VStack{
                                    }
                                    .frame(width: 14, height: 14)
                                    .background(Color("\(film.color)"))
                                    .cornerRadius(20)
                                    
                                    
                                }
                                .font(.system(size: 16)).fontWeight(.semibold)
                                Text("Price \(film.price) CAD")
                                    .font(.system(size: 16)).fontWeight(.semibold)
                                
                            }
                            .padding(.leading,-10)
                        }
                        
                    }
                    
                    
                    
                    
                }
                Spacer()
                NavigationLink(destination: CheckoutView()){
                    HStack(){
                        Spacer()
                        Text("Go to Checkout")
                            .foregroundColor(Color.white)
                        Spacer()
                        
                    }
                    .padding(20)
                    .background(Color("AppBlue"))
                    .cornerRadius(30)
                    .padding(20)
                }
                
                
                
            }
            
            
            .padding(10)
            .frame(maxWidth: .infinity , maxHeight: .infinity)
            .background(Color("BgColor"))
            
        }
        
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
