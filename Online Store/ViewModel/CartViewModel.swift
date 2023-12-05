//
//  CartViewModel.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//


import FirebaseFirestore
import Combine

// Define attributes in purchased cart in Firestore
struct CartItemModel: Identifiable {
    var id: String
    var color: String
    var image: String
    var name: String
    var price: String
}



class CartViewModel: ObservableObject {
    
    @Published var cart: [CartItemModel] = []

    private var cancellables: Set<AnyCancellable> = []
    private var listener: ListenerRegistration?
    
    private var timer: Timer?

    init() {
        setupTimer()
        fetchCart()
    }
    
    
    // Timer is used for fetch new data always
    private func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.fetchCart()
        }
    }

    // Fetch firestore data
    private func fetchCart() {
        
        // Define db
        let db = Firestore.firestore()
        
        // Define Collecetion (Name : "cart")
        let cartCollection = db.collection("cart")
        
        listener?.remove() // Remove previous listener

        listener = cartCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                return
            }
            
            self.cart = documents.compactMap { document in
                let id = document.documentID

                guard
                    // Bind firebase data with Film Model
                    let color = document["color"] as? String,
                    let image = document["image"] as? String,
                    let name = document["name"] as? String,
                    let price = document["price"] as? String

                else {
                    return nil
                }
                
                // resturn film data (purchased)
                return CartItemModel(id : id, color: color, image: image, name: name, price: price)
            }
        }
    }

    deinit {
        timer?.invalidate()
        listener?.remove()
    }
}
