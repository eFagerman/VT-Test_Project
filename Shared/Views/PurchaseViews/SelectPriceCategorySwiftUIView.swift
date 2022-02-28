//
//  SelectPriceCategorySwiftUIView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-23.
//

import SwiftUI

struct SelectPriceCategorySwiftUIView: View {
    
    @ObservedObject var shoppingCart: ShoppingCart
    
    var body: some View {
        
        VStack {
            
            List {
                
                // TICKET TYPE
                Section(header: Text("Biljettyp")) {
                    Text(shoppingCart.productType.name)
                }
                
                
                // ZONE
                if let zone = shoppingCart.productType.zone {
                    Section(header: Text("Zon")) {
                        Text(zone)
                    }
                }
                
                
                // PRICE CLASS
                Section(header: Text("Prisklass")) {
                    
                    ForEach($shoppingCart.items) { $item in
                        PriceClassRow(shoppingCartItem: $item)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .padding(.top)
            
            Spacer()
            
            let viewModel = PurchaseSummaryViewModel(shoppingCart: shoppingCart)
            NavigationLink("Köp biljett") {
                PurchaseSummarySwiftUIView(viewModel: viewModel)
                    .navigationTitle("Köp biljett")
            }
           
        }
        .navigationTitle(shoppingCart.ticketOperator.name)
        
    }
}

//struct SelectPriceCategorySwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectPriceCategorySwiftUIView()
//    }
//}
