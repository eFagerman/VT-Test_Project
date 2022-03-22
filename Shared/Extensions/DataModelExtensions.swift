//
//  ModelExtensions.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-03-18.
//

import Foundation
import SwiftUI

extension ResponseOperator: ContainsTextResources, Identifiable {
    
    public var id: String {
        return code
    }
    
    var title: String {
        return localization(for: "operator.title") ?? ""
    }
    
    var image: Image {
        // TODO: fetch this logo from the backend
        return Image(code).renderingMode(.original)
    }
}

extension ResponseOperatorProduct: ContainsTextResources, Identifiable {
    
    var title: String {
        return localization(for: "product.title") ?? ""
    }
}

extension ResponseOperatorPriceGroup: ContainsTextResources {
    
    var title: String {
        return localization(for: "pricegroup.title") ?? ""
    }
}


