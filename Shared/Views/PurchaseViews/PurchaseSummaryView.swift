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
    let footerTitle = "Footer text. Footer text. Footer text. Footer text. Footer text. Footer text. Footer text. Footer text."
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
            
            
            
            // PRODUCT HEADER
            SectionHeaderView(title: viewModel.yourTicketTitle)
            
            VStack {
                // PRODUCT CELLS
                ImageTextRow(image: viewModel.shoppingCart.ticketOperator.image, text: viewModel.shoppingCart.ticketOperator.name)
                    .padding(.vertical)
                    .foregroundColor(.white)
                DividerTight()
                TicketInfoView(shoppingCartItems: viewModel.shoppingCart.items)
                    .padding()
                DividerTight()
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.sumTitle).font(.applicationFont(withWeight: .bold, andSize: 17))
                        Text(viewModel.vatTitle).font(.applicationFont(withWeight: .regular, andSize: 15))
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(viewModel.shoppingCart.totalPriceWithCurrency).font(.applicationFont(withWeight: .bold, andSize: 17))
                        Text(viewModel.amountTitle).font(.applicationFont(withWeight: .regular, andSize: 15))
                    }
                }
                .padding()
            }
            .background(Color(UIColor.gray))
            .cornerRadius(7.5)
            .padding(.horizontal, 12)

            
            HStack {
                Text(viewModel.footerTitle)
                    .font(.applicationFont(withWeight: .regular, andSize: 15))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 1)

            Spacer()
            
            Text("THE PAYMENT METHOD PART IS IN THE MAIN PROJECT AS SWIFTUI CODE ALREADY ")

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

