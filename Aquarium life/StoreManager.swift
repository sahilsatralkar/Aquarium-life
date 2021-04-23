//
//  StoreManager.swift
//  Aquarium life
//
//  Created by Sahil Satralkar on 29/01/21.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @Published var myProducts = [SKProduct]()
    
    @Published var transactionState: SKPaymentTransactionState?
    
    var request: SKProductsRequest!
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Did receive response")
            
            if !response.products.isEmpty {
                for fetchedProduct in response.products {
                        DispatchQueue.main.async {
                            self.myProducts.append(fetchedProduct)
                        }
                    }
                for invalidIdentifier in response.invalidProductIdentifiers {
                    print("Invalid identifiers found: \(invalidIdentifier)")
                }
            }
    }
    
    func getProducts(productIDs: [String]) {
        print("Start requesting products ...")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
                switch transaction.transactionState {
                
                case .purchasing:
                    transactionState = .purchasing
                    
                case .purchased:
                    UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                    queue.finishTransaction(transaction)
                    transactionState = .purchased
               
                case .restored:
                    UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                    queue.finishTransaction(transaction)
                    transactionState = .restored
                
                case .failed, .deferred:
                    print("Payment Queue Error: \(String(describing: transaction.error))")
                    queue.finishTransaction(transaction)
                    transactionState = .failed
                
                default:
                    queue.finishTransaction(transaction)
                }
            }
    }
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
                    SKPaymentQueue.default().add(payment)
                
            } else {
                print("User can't make payment.")
            }
            
    }
    
    //Restore purchases
    func restoreProducts() {
        print("Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}
