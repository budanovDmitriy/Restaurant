//
//  CheckoutView.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var order: Order
    
    static let paymentTypes = ["Наличными", "Visa", "MasterCard", "Maestro", "Белкарт", "Мир"]
    static let tips = [0,10,15,20,25]
    static let pickUpTime = ["Сейчас", "Сегодня вечером", "Завтра Утром"]
    
    @State private var paymentType = 0
    @State private var isUseLoyaltyDetails = false
    @State private var loyaltyNumbers = ""
    @State private var tipsAmount = 0
    @State private var isShowingPaymentAlert = false
    @State private var pickUpAt = 0
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tip = total / 100 * Double(Self.tips[tipsAmount])
        return total + tip
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Выберите способ оплаты", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                
                Toggle(isOn: $isUseLoyaltyDetails.animation()) {
                    Text("Использовать карту постоянного клиента ?")
                }
                
                if isUseLoyaltyDetails {
                    TextField("Введите код карты постоянного клиента", text: $loyaltyNumbers)
                }
            }
            
            Section (header: Text("Оставить чаевые?")) {
                Picker("Размер чаевых: ", selection: $tipsAmount) {
                    ForEach(0 ..< Self.tips.count) {
                        Text("\(Self.tips[$0])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Когда забарть?")) {
                Picker("Время заказа", selection: $pickUpAt) {
                    ForEach(0 ..< Self.pickUpTime.count) {
                        Text(Self.pickUpTime[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
            }
            
            Section ( header: Text("Итого: Рублей \(totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                Button("Подтвердить покупку") {
                    self.isShowingPaymentAlert.toggle()
                }
            }
            
        }.navigationBarTitle("Заказ", displayMode: .inline)
            .alert(isPresented: $isShowingPaymentAlert) {
                Alert(title: Text("Платеж подтвержден"), message: Text("Итого  \(totalPrice, specifier: "%2.f") рублей "), dismissButton: .default(Text("Ok")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    
    static let order = Order()
    
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}

