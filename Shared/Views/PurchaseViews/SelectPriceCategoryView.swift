//
//  SelectPriceCategoryView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-23.
//

import SwiftUI

struct SelectPriceCategoryView: View {
    
    @ObservedObject var shoppingCart: ShoppingCart
    
    var body: some View {
        
        VStack {
            
            ScrollView {

                // TICKET TYPE HEADER
                SectionHeaderView(title: "Biljettyp", changeButton: true)

                // TICKET TYPE CELL
                SimpleCell(title: shoppingCart.productType.name)
                
                // ZONE
                if let zone = shoppingCart.productType.zone {
                    
                    // ZONE HEADER
                    SectionHeaderView(title: "Zon", changeButton: true)

                    // ZONE CELL
                    SimpleCell(title: zone)
                    
                }
                
                // PRICE CLASS
                
                SectionHeaderView(title: "Prisklass")

                ForEach($shoppingCart.items) { $item in
                    PriceClassRow(shoppingCartItem: $item)
                }

            }
            .padding(.top)
            
            Spacer()
            
            let viewModel = PurchaseSummaryViewModel(shoppingCart: shoppingCart)
            NavigationLink("Köp biljett") {
                PurchaseSummaryView(viewModel: viewModel)
                    .navigationTitle("Köp biljett")
            }
           
        }
        .navigationTitle(shoppingCart.ticketOperator.name)
        
    }
}

struct SelectPriceCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.slTicketOperator, productType: ProductsData.shared.slProduct1)
        SelectPriceCategoryView(shoppingCart: shoppingCart)
        let shoppingCart2 = ShoppingCart(ticketOperator: ProductsData.shared.slTicketOperator, productType: ProductsData.shared.slProduct2)
        SelectPriceCategoryView(shoppingCart: shoppingCart2)
    }
}
