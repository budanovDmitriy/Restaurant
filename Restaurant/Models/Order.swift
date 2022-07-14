//
//  Order.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//


import SwiftUI

class Order: ObservableObject {
    
    @Published var items = [MenuItem]()

    var total: Int {
        if items.count > 0 {
            return items.reduce(0) { $0 + ($1.price * $1.quantity) }
        } else {
            return 0
        }
    }
    
    func countOf(_ item: MenuItem) -> Int {
        guard let index = items.firstIndex(of: item) else { return 0 }
        return items[index].quantity
    }

    func add(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items[index].quantity += 1
        } else {
            var addingItem = item
            addingItem.quantity = 1
            items.append(addingItem)
        }
    }

    func remove(item: MenuItem) {
        guard let index = items.firstIndex(of: item) else {
            print("empty")
            return
        }
        
        items[index].quantity -= 1
        if items[index].quantity < 1 {
            items.remove(at: index)
        }
    }
    
    func clean() {
        items.removeAll()
    }
   
}
