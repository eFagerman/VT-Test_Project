//
//  ZoneSelectorView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-02-28.
//

import SwiftUI

struct ZoneSelectorView: View {
    
    @ObservedObject var shoppingCart: ShoppingCart
    
    var body: some View {
        VStack {

            Text(shoppingCart.productType.name)
            
            Spacer()
            NavigationLink("Köp biljett") {
                SelectPriceCategorySwiftUIView(shoppingCart: shoppingCart)
                    .navigationTitle("Köp biljett")
            }

        }
    }
}

/*
struct ZoneSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneSelectorView()
    }
}
*/
