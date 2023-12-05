//
//  CheckoutView.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-04.
//

import SwiftUI

struct CheckoutView: View {
    @State var name : String = ""
    @State var address : String = ""
    @State var card : String = ""
    @State var date : String = ""
    @State var cvv : String = ""

    var body: some View {
        VStack{
            HStack{
                Text("Checkout")
                    .font(.system(size: 20)).fontWeight(.semibold)
                    .padding(.leading)
                Spacer()
            }
            CustomTextField(email: $name, inputTitle: "Name")
            CustomTextField(email: $address, inputTitle: "Address")
            HStack{
                Text("Billing Details")
                    .font(.system(size: 20)).fontWeight(.semibold)
                    .padding(.leading)
                Spacer()
            }
            .padding(.top)
            CustomTextField(email: $card, inputTitle: "Card Number")
            HStack{
                CustomTextField(email: $date, inputTitle: "Date")
                CustomTextField(email: $cvv, inputTitle: "CVV")

            }
            Spacer()
            HStack(){
                Spacer()
                Text("Purchase Now")
                    .foregroundColor(Color.white)
                Spacer()

            }
            .padding(20)
            .background(Color("AppBlue"))
            .cornerRadius(30)


        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BgColor"))
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
