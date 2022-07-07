//
//  MenuItemRow.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI

struct MenuItemRow: View {
    static let colors: [String: UIColor] = ["D": .systemPurple, "G": .systemTeal, "N":.systemRed, "S": .systemBlue, "V": .systemGreen]
    @EnvironmentObject var order: Order
    var item: MenuItem
    
    var body: some View {
        NavigationLink(destination: MenuDetailView(item: item)) {
            HStack {
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                    .overlay(Circle()
                    .stroke(Color.gray, lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text(item.name).font(.headline)
                    Text(" \(item.price) рублей")
                }.layoutPriority(1)
                
                Spacer()
                
                Stepper("",
                        onIncrement: {
                            self.order.add(item: self.item)
                        },
                        onDecrement: {
                            self.order.remove(item: self.item)
                        })
            }
        }
    }
}

struct MenuItemRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemRow(item: MenuItem.example)
    }
}

