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
    var ticketOperator: ResponseOperator
    var product: ResponseOperatorProduct
    var priceGroup: ResponseOperatorPriceGroup
    var price: ResponseOperatorProductPrice
    var number: Int
}

class ShoppingCart: ObservableObject {

    @Published var items = [ShoppingCartItem]()
    private (set) var ticketOperator: ResponseOperator
    private (set) var product: ResponseOperatorProduct
    
    var totalPrice: Int {
        return items.map({$0.number * Int($0.price.amountTotal ?? 0)}).reduce(0, +)
    }
    
    var totalPriceWithCurrency: String {
        return String(totalPrice) + " kr"
    }
    
    func addItem(_ item: ShoppingCartItem) {
        self.items.append(item)
    }
    
    init(ticketOperator: ResponseOperator, product: ResponseOperatorProduct) {
        self.ticketOperator = ticketOperator
        self.product = product

        var i = [ShoppingCartItem]()

        if let priceGroups = product.priceGroups {
            priceGroups.forEach { priceGroup in
                
                if let price = product.prices?.first(where: {$0.priceGroupId == priceGroup.id }) {
                    let newItem = ShoppingCartItem(ticketOperator: ticketOperator, product: product, priceGroup: priceGroup, price: price, number: 0)
                    i.append( newItem)
                }
            }
        }
        self.items = i
    }
}
