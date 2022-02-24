//
//  Model.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-10.
//

import Foundation
import SwiftUI

enum ApplicationFontWeight: String {
    case regular = "Sk-Modernist-Regular"
    case bold = "Sk-Modernist-Bold"
    case mono = "Sk-Modernist-Mono"
}

extension Font {
    
    static var h4: Font {
        return Font.custom("Sk-Modernist-Bold", size: 25.0)
    }
    
    static var h6: Font {
        return Font.custom("Sk-Modernist-Bold", size: 17.0)
    }
    
    static var body: Font {
        return Font.custom("Sk-Modernist-Regular", size: 17.0)
    }
    
    static func applicationFont(withWeight weight: ApplicationFontWeight, andSize size: CGFloat) -> Font {
        
        return Font.custom(weight.rawValue, size: size)
    }
}


struct TicketModel {
    
    
    var priceCategory: String = "1 Vuxen"
    var operatorImage: Image = Image(systemName: "heart.fill")
    var identifier: String = "1234 567890"
    var type: String = "Singelbiljett"
    var travelPeriodsRemaining: Int = 1
    let expireDate: Date = Date(timeIntervalSinceNow: 60)
    var lastActivationDay: Date = Date()
    
}



