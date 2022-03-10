//
//  PurchaseSummaryView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-24.
//

import SwiftUI

struct PaymentMethod: Hashable, SelectableItem {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    var name: String
    var image: Image
}

class PurchaseSummaryViewModel: ObservableObject {
    
    var shoppingCart: ShoppingCart
    @Published var paymentMethods: [PaymentMethod] = [PaymentMethod(name: "Betalkort", image: Image(systemName: "creditcard")), PaymentMethod(name: "Swish", image: Image(systemName: "line.3.crossed.swirl.circle"))]
    let yourTicketTitle = "Din biljett"
    let footerTitle = "Footer text"
    let sumTitle = "Summa:"
    let vatTitle = "Moms"
    let amountTitle = "42 kr"
    let choosePaymentMethodTitle = "Välj betalmetod"
    let payTitle = "Betala"
    
    init(shoppingCart: ShoppingCart) {
        self.shoppingCart = shoppingCart
    }
}


struct PurchaseSummaryView: View {
    
    @ObservedObject var viewModel: PurchaseSummaryViewModel
    
    @State var selectablePaymentMethod: PaymentMethod? = nil
    
    var body: some View {
        
        VStack {
            
            
            // TICKET
            List {
                
                Section(header: Text(viewModel.yourTicketTitle)
                            .padding(.leading, -16)
                            .font(.applicationFont(withWeight: .bold, andSize: 13)),
                        footer: Text(viewModel.footerTitle)
                            .padding(.leading, -16)
                            .font(.applicationFont(withWeight: .regular, andSize: 13))) {
                    
                    ImageTextRow(image: viewModel.shoppingCart.ticketOperator.image, text: viewModel.shoppingCart.ticketOperator.name)
                    
                    TicketInfoView(shoppingCartItems: viewModel.shoppingCart.items)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewModel.sumTitle).font(.applicationFont(withWeight: .bold, andSize: 17))
                            Text(viewModel.vatTitle).font(.applicationFont(withWeight: .regular, andSize: 15))
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text(viewModel.shoppingCart.totalPriceWithCurrency).font(.applicationFont(withWeight: .bold, andSize: 17))
                            Text(viewModel.amountTitle).font(.applicationFont(withWeight: .regular, andSize: 15))
                        }
                    }
                }
                
                Text("THE PAYMENT METHOD PART IS IN THE MAIN PROJECT AS SWIFTUI CODE ALREADY ")

            }
            .listStyle(.automatic)
            .padding(.top)
            
            
            // PAYMENT METHOD
            /*
            List {
                
                Section(header: Text(viewModel.choosePaymentMethodTitle).font(.applicationFont(withWeight: .bold, andSize: 13))) {
                    
                    ForEach(viewModel.paymentMethods, id: \.self) { paymentMetod in
                        SelectableRow(image: paymentMetod.image, title: paymentMetod.name, item: paymentMetod, selectedItem: $selectablePaymentMethod)
                    }
                }
            }
            .listStyle(.grouped)
            */
            
            Spacer()
            
            Button(viewModel.payTitle) {
                
            }
            
        }
    }
}

struct PurchaseSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseSummaryView(viewModel: PurchaseSummaryViewModel(shoppingCart: ShoppingCart(ticketOperator: ProductsData.shared.vtTicketOperator, productType: ProductsData.shared.vtTicketOperator.productTypes[0])))
    }
}
