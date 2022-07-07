//
//  Favorite.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI

class Favorite: ObservableObject {
    
    @Published var items = [MenuItem]()
    
    func isFavorite(item: MenuItem) -> Bool {
        return items.contains(item)
    }

    func add(item: MenuItem) {
        items.append(item)
    }

    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    
}
