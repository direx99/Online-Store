//
//  CartViewModel.swift
//  Online Store
//
//  Created by Dinith Hasaranga on 2023-12-03.
//


import FirebaseFirestore
import Combine

// Define attributes in purchased account in Firestore
struct AccountModel: Identifiable {
    var id: String
    var name: String
    var email: String
    var phone: String
}



class AccountViewModel: ObservableObject {
    
    @Published var account: [AccountModel] = []

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
        
        // Define Collecetion (Name : "account")
        let cartCollection = db.collection("account")
        
        listener?.remove() // Remove previous listener

        listener = cartCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                return
            }
            
            self.account = documents.compactMap { document in
                let id = document.documentID

                guard
                    // Bind firebase data with Film Model
                    let name = document["name"] as? String,
                        let email = document["email"] as? String,
                        let phone = document["phone"] as? String


                else {
                    return nil
                }
                
                // resturn film data (purchased)
                return AccountModel(id: id, name: name, email: email, phone: phone)
            }
        }
    }

    deinit {
        timer?.invalidate()
        listener?.remove()
    }
}


extension AccountViewModel {
    func getAccountWithEmail(_ email: String) -> AccountModel? {
        return account.first(where: { $0.email.lowercased() == email.lowercased() })
    }
}
