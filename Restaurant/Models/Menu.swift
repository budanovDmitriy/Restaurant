//
//  Menu.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI

struct MenuSection: Codable, Identifiable {
    var id: UUID
    var name: String
    var items: [MenuItem]
}

struct MenuItem: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var imageName: String
    var nationalDish: String
    var price: Int
    var restrictions: [String]
    var description: String
    var quantity: Int = 0

    var thumbnailImage: String {
        "\(imageName)-mini"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
            && lhs.description == rhs.description
            && lhs.price == rhs.price
    }

    static let example = MenuItem(id: UUID(), name: "Драники", imageName: "mexican", nationalDish: "Белорусское", price: 6000, restrictions: ["G", "V"], description: "Вкусное блюдо из картофеля с мясом", quantity: 0)

}
