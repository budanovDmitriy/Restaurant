//
//  Helper.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import Foundation
import Alamofire
import SwiftUI




class Helper {
    
    
    func fetchPayment() {
        var jsonData: Data = Data()
        let request = AF.request("https://github.com/budanovDmitriy/Restaurant/blob/main/Restaurant/Data/makeOrder.json")
        request.validate().response { response in
            guard let items = response.value else {
                fatalError("Failed to load ")
            }
            jsonData = items ?? Data()
        }
        let payment = try? JSONDecoder().decode(Payment.self, from: jsonData)
        print(payment ?? "free")
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}


extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
    
}

