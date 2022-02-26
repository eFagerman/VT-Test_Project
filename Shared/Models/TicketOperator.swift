//
//  TicketOperator.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-25.
//

import Foundation
import SwiftUI

struct TicketOperator: Hashable, Identifiable {
    var id: String
    var name: String
    var productTypes: [ProductType]
    var priceGroups: [PriceGroup]
    var image: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PriceGroup: Hashable, Identifiable {
    var id: String
    var name: String
    var price: Int
    var currency: String = "kr"
}

extension PriceGroup {
    
    var priceWithCurrency: String {
        return String(price) + " " + currency
    }
}

struct ProductType: Hashable, Identifiable {
    var id: String
    var name: String
    var zone: String? = nil
    var priceGroups: [String]
}
