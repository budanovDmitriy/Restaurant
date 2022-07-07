//
//  FavoriteView.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var favorite: Favorite
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favorite.items) { item in
                    MenuItemRow(item: item)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Избранное")
            
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    
    static let favorite = Favorite()
    
    static var previews: some View {
        FavoriteView().environmentObject(favorite)
    }
}
