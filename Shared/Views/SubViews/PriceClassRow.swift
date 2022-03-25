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
                Text(shoppingCartItem.priceGroup.title).font(.applicationFont(withWeight: .bold, andSize: 15))
                    .foregroundColor(Color(UIColor.Popup.title))
                Spacer().frame(height: 4)
                Text(String(shoppingCartItem.price.amountTotal!)).font(.applicationFont(withWeight: .regular, andSize: 13))
                    .foregroundColor(Color(UIColor.Text.label))
            }
            .padding()
            
            Spacer()
            
            CustomStepper(value: $shoppingCartItem.number, range: 0...100)
                .font(.applicationFont(withWeight: .bold, andSize: 17))
        }
        .background(Color(UIColor.General.secondComplementBackground))
    }
}

//struct PriceClassRow_Previews: PreviewProvider {
//    static var previews: some View {
//        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.data.operators.first!, product: ProductsData.shared.data.operators.first!.productTypes!.first!)
//        
//        if let item = shoppingCart.items.first {
//            PriceClassRow(shoppingCartItem: .constant(item))
//        }
//    }
//}
