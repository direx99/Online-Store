//
//  ClothProductViewModel.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//

import Foundation

struct ClothProduct: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var brand: String
    var price: String
    var image: String
    var colors: [String]
    var code: String
}

class ClothProductViewModel: ObservableObject {
    @Published var product: ClothProduct
    
    init(product: ClothProduct) {
        self.product = product
    }
}
