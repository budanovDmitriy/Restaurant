//
//  MenuDetailView.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI

struct MenuDetailView: View {
    
    @EnvironmentObject var order: Order
    @EnvironmentObject var favorite: Favorite
    @State var isFavorite = false
    var item: MenuItem
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                Image(item.imageName)
                Text(item.nationalDish)
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -10, y: -5)
            }
            
            Text(item.description)
            .padding()
            
            Spacer()
            
                
                Button(action: {
                    
                    if self.isFavorite {
                        self.favorite.remove(item: self.item)
                    } else {
                        self.favorite.add(item: self.item)
                    }
                    
                    self.isFavorite = !self.isFavorite
                    
                }) {
                    
                    if isFavorite {
                        Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.red)
                        
                    } else {
                        Image(systemName: "heart")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.red)
                    }
                    
                }.padding(10)
            
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(10)
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
        .onAppear(perform: fetchIsFavorite)
    }
    
    private func fetchIsFavorite() {
        self.isFavorite = favorite.isFavorite(item: self.item)
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static let order = Order()
    static let favorite = Favorite()
    
    static var previews: some View {
        NavigationView {
            MenuDetailView(item: MenuItem.example)
                .environmentObject(order)
                .environmentObject(favorite)
        }
    }
}
