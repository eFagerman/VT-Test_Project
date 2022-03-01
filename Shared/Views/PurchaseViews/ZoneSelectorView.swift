//
//  ZoneSelectorView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-02-28.
//

import SwiftUI


class ZoneSelectorViewModel: ObservableObject {
    
    let ticketTypeSectionTitle = "Biljettyp"
    let ticketTypeSectionÄndra = "Ändra"
    let zoneSearchSectionTitle = "Sök zon"
    let zoneSelectionSectionTitle = "Välj zon"
    
    @Published var shoppingCart: ShoppingCart
  
    init(shoppingCart: ShoppingCart) {
        self.shoppingCart = shoppingCart
    }
}


struct ZoneSelectorView: View {
    
    @Environment(\.presentationMode) var presentation

    @ObservedObject var viewModel: ZoneSelectorViewModel

    
    var body: some View {
        VStack {
            
            List {
                
                // TICKET TYPE
                Section(header: ticketTypeSectionHeaderView()) {
                    Text(viewModel.shoppingCart.productType.name)
                }
                .textCase(nil)
                
                // ZONE SEARCH
                Section(header: Text(viewModel.zoneSearchSectionTitle)) {
                    Text("")
                }
                .textCase(nil)

                // ZONE SELECTION
                Section(header: Text(viewModel.zoneSelectionSectionTitle)) {
                    Text("")
                }
                .textCase(nil)

            }
            .listStyle(GroupedListStyle())
            .padding(.top)
            .navigationTitle(viewModel.shoppingCart.ticketOperator.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Info") {
                        print("Help tapped!")
                    }
                }
            }

            
            Spacer()
            NavigationLink("Köp biljett") {
                SelectPriceCategorySwiftUIView(shoppingCart: viewModel.shoppingCart)
                    .navigationTitle("Köp biljett")
            }
        }
    }
    
    private func ticketTypeSectionHeaderView() -> some View {
        HStack {
            Text(viewModel.ticketTypeSectionTitle)
            Spacer()
            Button(viewModel.ticketTypeSectionÄndra) {
                presentation.wrappedValue.dismiss()
            }
        }
    }


}

struct ZoneSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneSelectorView(viewModel: ZoneSelectorViewModel(shoppingCart: ShoppingCart(ticketOperator: ProductsData.shared.vtTicketOperator, productType: ProductsData.shared.vtTicketOperator.productTypes[0])))
    }
}
