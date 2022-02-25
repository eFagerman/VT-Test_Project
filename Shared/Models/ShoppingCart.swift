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
    var productType: ProductType
    var priceGroup: PriceGroup
    var number: Int
}

class ShoppingCart: ObservableObject {

    @Published var items: [ShoppingCartItem]
    private (set) var ticketOperator: TicketOperator
    private (set) var productType: ProductType
    
    var totalPrice: Int {
        return items.map({$0.number * $0.priceGroup.price}).reduce(0, +)
    }
    
    var totalPriceWithCurrency: String {
        return String(totalPrice) + " kr"
    }
    
    init(ticketOperator: TicketOperator, productType: ProductType) {
        self.ticketOperator = ticketOperator
        self.productType = productType
        
        var i = [ShoppingCartItem]()
        
        productType.priceGroups.forEach { priceGroupId in
            
            if let priceGroup = ticketOperator.priceGroups.first(where: { $0.id == priceGroupId }) {
                let newItem = ShoppingCartItem(productType: productType, priceGroup: priceGroup, number: 0)
                i.append( newItem)
            }
        }
        
        self.items = i
    }
}
