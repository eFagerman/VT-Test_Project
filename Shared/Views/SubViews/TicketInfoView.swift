//
//  TicketInfoView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-08.
//

import SwiftUI

extension ShoppingCartItem {
    
    var description: String {
        return String(number) + " " + priceGroup.title + " " + productType.title
    }
}

struct TicketInfoView: View {
    
    var shoppingCartItems: [ShoppingCartItem]
    
    var body: some View {
        
        VStack {
//            ForEach(shoppingCartItems.filter({$0.number > 0})) { shoppingCartItem in
                ForEach(shoppingCartItems) { shoppingCartItem in
                
                HStack {
                    Text(shoppingCartItem.description)
                    Spacer()
                    Text(String(shoppingCartItem.price.amountTotal ?? 0))
                }
                .font(.applicationFont(withWeight: .regular, andSize: 15))
                    if shoppingCartItem != shoppingCartItems.last {
                        Spacer().frame(height: 8)
                    }

            }
        }
    }
}

//struct TicketInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.vtTicketOperator, product: ProductsData.shared.vtTicketOperator.products[0])
//        TicketInfoView(shoppingCartItems: shoppingCart.items)
//    }
//}

