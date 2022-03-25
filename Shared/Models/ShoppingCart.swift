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
    var productType: ResponseOperatorProductType
    var product: ResponseOperatorProductTypeProduct
    var zone: ResponseOperatorZone
    var priceGroup: ResponseOperatorPriceGroup
    var price: ResponseOperatorProductPrice
    var number: Int
}

class ShoppingCart: ObservableObject {
    
    @Published var selectableItems = [ShoppingCartItem]()
    @Published var ticketOperator: ResponseOperator?
    @Published var productType: ResponseOperatorProductType? {
        didSet {
            self.product = productType?.products?.first
            self.zone = productType?.zones?.first
        }
    }
   
    @Published var zone: ResponseOperatorZone? {
        didSet {
            updateSelectableItems()
        }
    }
    @Published var product: ResponseOperatorProductTypeProduct? {
        didSet {
            updateSelectableItems()
        }
    }
    
    var totalPrice: Int {
        return selectableItems.map({$0.number * Int($0.price.amountTotal ?? 0)}).reduce(0, +)
    }
    
    var totalPriceWithCurrency: String {
        return String(totalPrice) + " kr"
    }
    
    func selectableItems(ticketOperator: ResponseOperator, productType: ResponseOperatorProductType, product: ResponseOperatorProductTypeProduct, zone: ResponseOperatorZone) -> [ShoppingCartItem] {
     
        var items = [ShoppingCartItem]()

        if let priceGroups = productType.priceGroups {
            
            priceGroups.forEach { priceGroup in
                
                if let price = productType.prices?.first(where: {
                    $0.priceGroupId == priceGroup.id &&
                    $0.zoneId == zone.id &&
                    $0.productId == product.id }) {
                    
                    let newItem = ShoppingCartItem(ticketOperator: ticketOperator, productType: productType, product: product, zone: zone, priceGroup: priceGroup, price: price, number: 0)
                    items.append( newItem)
                }
            }
        }
        
        return items
    }
    
    private func updateSelectableItems() {
        
        guard let ticketOperator = self.ticketOperator else { return }
        guard let productType = self.productType else { return }
        guard let zone = self.zone else { return }
        guard let product = self.product else { return }
        
        self.selectableItems = selectableItems(ticketOperator: ticketOperator, productType: productType, product: product, zone: zone)
    }
    
}
