//
//  Order.swift
//  Cupcake Corner
//
//  Created by Aaryan Kothari on 30/03/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

class Order: ObservableObject{
    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnables = false{
        didSet{
            if specialRequestEnables == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
