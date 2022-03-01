//
//  ZoneSelectorView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-02-28.
//

import SwiftUI


class ZoneSelectorViewModel: ObservableObject {
    
    @Published var shoppingCart: ShoppingCart
  
    init(shoppingCart: ShoppingCart) {
        self.shoppingCart = shoppingCart
    }
}

struct ZoneSelectorView: View {
    
    @ObservedObject var viewModel: ZoneSelectorViewModel

    
    var body: some View {
        VStack {

            
            Text(viewModel.shoppingCart.productType.name)
            Spacer()
            NavigationLink("Köp biljett") {
                SelectPriceCategorySwiftUIView(shoppingCart: viewModel.shoppingCart)
                    .navigationTitle("Köp biljett")
            }
        }
    }

}

struct ZoneSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneSelectorView(viewModel: ZoneSelectorViewModel(shoppingCart: ShoppingCart(ticketOperator: ProductsData.shared.vtTicketOperator, productType: ProductsData.shared.vtTicketOperator.productTypes[0])))
    }
}
