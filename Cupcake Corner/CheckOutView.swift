//
//  CheckOutView.swift
//  Cupcake Corner
//
//  Created by Aaryan Kothari on 30/03/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct CheckOutView: View {
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
                    }.padding()
                }
            }
        }.navigationBarTitle("Check Out", displayMode: .inline)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
