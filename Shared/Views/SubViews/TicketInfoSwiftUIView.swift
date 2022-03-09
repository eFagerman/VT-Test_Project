//
//  TicketInfoView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-08.
//

import SwiftUI

struct TicketInfoView: View {
    
    var shoppingCartItems: [ShoppingCartItem]
    
    var body: some View {
        
        VStack {
            ForEach(shoppingCartItems.filter({$0.number > 0})) { shoppingCartItem in
                
                let number = String(shoppingCartItem.number)
                let priceClassName = shoppingCartItem.priceGroup.name
                let price = shoppingCartItem.priceGroup.priceWithCurrency
                let ticketType = shoppingCartItem.productType.name
                
                HStack {
                    Text(number + " " + priceClassName + " " + ticketType)
                    Spacer()
                    Text(price)
                }.font(.applicationFont(withWeight: .regular, andSize: 15))
            }
        }
    }
}
