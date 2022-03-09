//
//  PriceClassRow.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-08.
//

import SwiftUI

struct PriceClassRow: View  {
        
    @Binding var shoppingCartItem: ShoppingCartItem
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(shoppingCartItem.priceGroup.name).font(.applicationFont(withWeight: .bold, andSize: 15))
                Text(shoppingCartItem.priceGroup.priceWithCurrency).font(.applicationFont(withWeight: .regular, andSize: 13))
            }
            
            Spacer()
            
            Stepper(String(shoppingCartItem.number), value: $shoppingCartItem.number, in: 0...100)
                .frame(width: 120, alignment: .leading)
                .font(.applicationFont(withWeight: .bold, andSize: 17))
            
        }
        .background(Color.clear)
    }
}

struct PriceClassRow_Previews: PreviewProvider {
    static var previews: some View {
        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.slTicketOperator, productType: ProductsData.shared.slProduct1)
        let item = shoppingCart.items.first!
        PriceClassRow(shoppingCartItem: .constant(item))
    }
}
