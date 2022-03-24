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
    let title = "Köp biljett"
    let yourTicketTitle = "Din biljett"
    let footerTitle = "Footer text. Footer text. Footer text. Footer text. Footer text. Footer text. Footer text. Footer text."
    let sumTitle = "Summa:"
    let vatTitle = "Moms"
    let amountTitle = "42 kr"
    let choosePaymentMethodTitle = "Välj betalmetod"
    let payTitle = "Betala 70 kr"
    
    init(shoppingCart: ShoppingCart) {
        self.shoppingCart = shoppingCart
    }
}


struct PurchaseSummaryView: View {
    
    @Environment(\.presentationMode) var presentation

    @ObservedObject var viewModel: PurchaseSummaryViewModel
    
    @State var selectablePaymentMethod: PaymentMethod? = nil
    
    var body: some View {
        
        ZStack {
            
            Color(UIColor.General.backgroundTwo).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // PRODUCT HEADER
                SectionHeaderView(title: viewModel.yourTicketTitle)
                
                VStack {
                    // PRODUCT CELLS
                    ImageTextRow(imageUrlString: viewModel.shoppingCart.ticketOperator.iconUrl, text: viewModel.shoppingCart.ticketOperator.resources?["sv"]?["operator.title"] ?? "Operator")
                        .padding(.vertical)
                    DividerTight()
                    TicketInfoView(shoppingCartItems: viewModel.shoppingCart.items)
                        .padding()
                        .foregroundColor(Color(UIColor.Popup.title))
                    DividerTight()
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewModel.sumTitle).font(.applicationFont(withWeight: .bold, andSize: 17))
                                .foregroundColor(Color(UIColor.Popup.title))
                            Text(viewModel.vatTitle).font(.applicationFont(withWeight: .regular, andSize: 15))
                                .foregroundColor(Color(UIColor.Popup.title))
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(viewModel.shoppingCart.totalPriceWithCurrency).font(.applicationFont(withWeight: .bold, andSize: 17))
                                .foregroundColor(Color(UIColor.Popup.title))
                            Text(viewModel.amountTitle).font(.applicationFont(withWeight: .regular, andSize: 15))
                                .foregroundColor(Color(UIColor.Popup.title))
                        }
                    }
                    .padding()
                }
                .background(Color(UIColor.HistoricalTicket.boxBackgroundColor))
                .cornerRadius(7.5)
                .padding(.horizontal, 12)
                
                HStack {
                    Text(viewModel.footerTitle)
                        .font(.applicationFont(withWeight: .regular, andSize: 15))
                        .foregroundColor(Color(UIColor.Text.label))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 1)
                
                Spacer()
                
                Text("THE PAYMENT METHOD PART IS IN THE MAIN PROJECT AS SWIFTUI CODE ALREADY ")
                    .foregroundColor(Color(UIColor.Popup.title))
                
                Spacer()
                
                Button(action: {
                    print("Buy")
                }, label: {
                    HStack {
                        Spacer()
                        Text(viewModel.payTitle)
                            .font(.applicationFont(withWeight: .bold, andSize: 21))
                            .foregroundColor(Color(UIColor.baseBlack))
                        Spacer()
                    }
                    .frame(height: 48)
                    .background(Color(UIColor.accentGreen))
                    .padding(EdgeInsets(top: -8, leading: 0, bottom: 0, trailing: 0))
                    
                })
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.bottom, -8)
            .toolbar {
                ToolbarItem(placement: .navigation)  {
                    Image(systemName: "arrow.left")
                        .renderingMode(.template)
                        .foregroundColor(Color(UIColor.General.accentColor))
                        .onTapGesture {
                            // code to dismiss the view
                            self.presentation.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(viewModel.title)
                            .foregroundColor(Color(UIColor.Popup.title))
                            .font(.applicationFont(withWeight: .bold, andSize: 17))
                    }
                }
            }
        }
    }
}

struct PurchaseSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.data.operators.first!, product: ProductsData.shared.data.operators.first!.productTypes!.first!)
        let purchaseSummareyViewModel = PurchaseSummaryViewModel(shoppingCart: shoppingCart)
        PurchaseSummaryView(viewModel: purchaseSummareyViewModel)
    }
}

