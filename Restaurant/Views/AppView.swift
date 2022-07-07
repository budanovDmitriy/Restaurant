//
//  ContentView.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            MenuView().tabItem {
                Image(systemName: "list.dash")
                Text("Меню")
            }
            
            OrderView().tabItem {
                Image(systemName: "square.and.pencil")
                Text("Заказ")
            }
            
            FavoriteView().tabItem {
                Image(systemName: "heart")
                Text("Избранное")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        AppView().environmentObject(order)
    }
}
