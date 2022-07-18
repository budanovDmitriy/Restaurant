//
//  MenuView.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI
import Foundation
import Alamofire

struct MenuView: View {
    @State private var menu = [MenuSection]()
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            MenuItemRow(item: item)
                        }
                    }
                }
            }
            .navigationBarTitle("Меню")
            .listStyle(GroupedListStyle())
        }.onAppear(perform: fetchMenu)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

extension MenuView {
    func fetchMenu() {
        let request = AF.request("https://raw.githubusercontent.com/budanovDmitriy/Restaurant/main/Restaurant/Data/menu.json")
        request.validate().responseDecodable(of: [MenuSection].self) { response in
            guard let items = response.value else {
                fatalError("Failed to load ")
            }
            DispatchQueue.main.async {
                self.menu = items
            }
        }
    }
}
