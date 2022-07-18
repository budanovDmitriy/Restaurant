//
//  CheckoutView.swift
//  Restaurant
//
//  Created by Dmitriy Budanov on 30.06.2022.
//

import SwiftUI
import Alamofire

struct CheckoutView: View {
    
    @EnvironmentObject var order: Order
    @Environment(\.presentationMode) var presentationMode
    @State private var shouldAnimate = false
    
    // Static data
    static let paymentTypes = ["Наличными", "Visa", "MasterCard", "Maestro", "Белкарт", "Мир"]
    static let tips = [0, 10, 15, 20, 25]
    static let pickUpTime = ["Сейчас", "Сегодня вечером", "Завтра Утром"]
    
    // Pickers
    @State private var paymentType = paymentTypes[0]
    @State private var tipsAmount = tips[0]
    @State private var pickUpAt = pickUpTime[0]
    
    // Views
    @State private var isUseLoyaltyDetails = false
    @State private var loyaltyNumbers = ""
    
    //Navigation
    @State private var isShowingPaymentAlert = false
    
    var totalPrice: Double {
        let total = Double(order.total)
        let tip = total / 100 * Double(tipsAmount)
        return total + tip
    }
    
    var body: some View {
        Form {
            
            
            Section {
                Picker("Выберите способ оплаты", selection: $paymentType) {
                    ForEach(Self.paymentTypes, id: \.self) { paymentTypeValue in
                        Text(paymentTypeValue)
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
                    ForEach(Self.tips, id: \.self) { tipsValue in
                        Text("\(tipsValue)")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Когда забарть?")) {
                Picker("Время заказа", selection: $pickUpAt) {
                    ForEach(Self.pickUpTime, id: \.self) { pickUpTimeValue in
                        Text(pickUpTimeValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
            }
           
            Section ( header: Text("Итого: Рублей \(totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                Button("Подтвердить покупку") {
                    self.isShowingPaymentAlert.toggle()
                    Helper().fetchPayment()
                }
                
            }
            
        }.navigationBarTitle("Заказ", displayMode: .inline)
            .alert(isPresented: $isShowingPaymentAlert) {
                Alert(
                    title: Text("Платеж подтвержден"),
                    message: Text("Итого  \(totalPrice, specifier: "%2.f") рублей "),
                    dismissButton: .default(Text("Ok"), action: {
                     
                       
                       
                        
                        order.clean()
                        presentationMode.wrappedValue.dismiss()
                        
                        
                        // TODO: Выключить спинер
                    })
                )
            }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    
    static let order = Order()
    
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}

