//
//  SelectPriceCategoryView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-23.
//

import SwiftUI

class SelectPriceCategoryViewModel: ObservableObject {
    
    @Published var shoppingCart: ShoppingCart
    
    let ticketTypeTitle = "Biljettyp"
    let zoneTitle = "Zon"
    let priceClassTitle = "Prisklass"
    let buyTicketTitle = "Köp biljett"
    
    init(shoppingCart: ShoppingCart) {
        self.shoppingCart = shoppingCart
    }
}

struct SelectPriceCategoryView: View {
    
    @ObservedObject var viewModel: SelectPriceCategoryViewModel
    
    var body: some View {
        
        VStack {
            
            ScrollView {

                // TICKET TYPE HEADER
                SectionHeaderView(title: viewModel.ticketTypeTitle, changeButton: true)

                // TICKET TYPE CELL
                SimpleCell(title: viewModel.shoppingCart.productType.name)
                
                // ZONE
                if let zone = viewModel.shoppingCart.productType.zone {
                    
                    // ZONE HEADER
                    SectionHeaderView(title: viewModel.zoneTitle, changeButton: true)

                    // ZONE CELL
                    SimpleCell(title: zone)
                    
                }
                
                // PRICE CLASS
                
                SectionHeaderView(title: viewModel.priceClassTitle)
                
                Spacer().frame(height: 8)

                ForEach($viewModel.shoppingCart.items) { $item in
                    DividerTight()
                    PriceClassRow(shoppingCartItem: $item)
                }
                if viewModel.shoppingCart.items.count > 0 {
                    DividerTight()
                }

            }
            .padding(.top)
            
            Spacer()
            
            VStack {
                let viewModel2 = PurchaseSummaryViewModel(shoppingCart: viewModel.shoppingCart)
                NavigationLink(destination: PurchaseSummaryView(viewModel: viewModel2)
                                .navigationTitle(viewModel.buyTicketTitle)) {
                    HStack {
                        Spacer()
                        Text(viewModel.buyTicketTitle)
                        Spacer()
                    }
                    .frame(height: 48)
                }
                .contentShape(Rectangle())
                .font(.applicationFont(withWeight: .bold, andSize: 21))
            }
            .background(Color.yellow)
            .padding(EdgeInsets(top: -8, leading: 0, bottom: -12, trailing: 0))
           
        }
        .navigationTitle(viewModel.shoppingCart.ticketOperator.name)
        
    }
}

struct SelectPriceCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.slTicketOperator, productType: ProductsData.shared.slProduct1)
        SelectPriceCategoryView(viewModel: SelectPriceCategoryViewModel(shoppingCart: shoppingCart))
        let shoppingCart2 = ShoppingCart(ticketOperator: ProductsData.shared.slTicketOperator, productType: ProductsData.shared.slProduct2)
        SelectPriceCategoryView(viewModel: SelectPriceCategoryViewModel(shoppingCart: shoppingCart2))
    }
}
