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
        
        NavigationView {
            
            VStack {
                
                List {
                    
                    // TICKET TYPE
                    Section(header: Text("Biljettyp")) {
                        Text(shoppingCart.product.name)
                    }
                    
                    
                    // ZONE
                    if let zone = shoppingCart.product.zone {
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
                
                Button("Köp biljett") {
                    print(shoppingCart.items)
                }
            }
        }
        .navigationTitle(shoppingCart.product.operatorName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct SelectPriceCategorySwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectPriceCategorySwiftUIView()
//    }
//}
