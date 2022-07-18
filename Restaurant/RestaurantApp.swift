//
//  RestaurantApp.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI

@main
struct RestaurantApp: App {
    var body: some Scene {
        let order = Order()
        let favorite = Favorite()
        
        
        WindowGroup {
            AppView().environmentObject(order)
                .environmentObject(favorite)
        }
    }
}
