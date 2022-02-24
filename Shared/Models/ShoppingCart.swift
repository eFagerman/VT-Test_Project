//
//  ShoppingCart.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-24.
//

import Foundation
import SwiftUI


struct ShoppingCartItem: Hashable, Identifiable {
    var id: Self { self }
    var product: Product
    var priceClass: PriceClass
    var number: Int
}

class ShoppingCart: ObservableObject {

    @Published var items: [ShoppingCartItem]
    private (set) var product: Product
    
    init(product: Product) {
        self.product = product
        
        var i = [ShoppingCartItem]()
        product.priceClasses.forEach { priceClass in
            let newItem = ShoppingCartItem(product: product, priceClass: priceClass, number: 0)
            i.append( newItem)
        }
        
        self.items = i
    }
}
