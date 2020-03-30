//
//  CheckOutView.swift
//  Cupcake Corner
//
//  Created by Aaryan Kothari on 30/03/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct CheckOutView: View {
    @State private var confirmationMessage = ""
    @State private var showConfirmation = Bool()
    @ObservedObject var order : Order
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order"){
                        //place order
                        self.placeOrder()
                    }.padding()
                }
            }
        }.navigationBarTitle("Check Out", displayMode: .inline)
            .alert(isPresented: $showConfirmation) {
                Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
        func placeOrder(){
            guard let encoded = try? JSONEncoder().encode(order)
                else{
                    print("Failed to encode")
                    return
            }
        
            let url = URL(string: "https://reqres.in/api.cupcakes")!
            
            var request = URLRequest(url: url)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = encoded
            
            URLSession.shared.dataTask(with: request){ data, response, error in
                //handle the result
                guard let data = data else{
                    print("No data in response: \(error?.localizedDescription ?? "IDK some error")")
                    return
                }
                if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data){
                    self.confirmationMessage = "Your order for \(decodedOrder.quantity)x\(Order.types[decodedOrder.type].lowercased()) cupcakes in on its way!"
                }else{
                    print("Invalid response from server")
                }
            }.resume()
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
