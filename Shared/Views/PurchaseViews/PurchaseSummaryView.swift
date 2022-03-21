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
    let payTitle = "Betala 70 kr"
    
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
                ImageTextRow(image: Image(systemName: "tortoise.fill"), text: viewModel.shoppingCart.ticketOperator.title)
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
            
            
            
            
            
            
            
            
            Button(action: {
                print("Buy")
            }, label: {
                HStack {
                    Spacer()
                    Text(viewModel.payTitle)
                        .font(.applicationFont(withWeight: .bold, andSize: 21))
                        .foregroundColor(.black)
                    Spacer()
                }
                .frame(height: 48)
                .background(Color.green)
                .padding(EdgeInsets(top: -8, leading: 0, bottom: -12, trailing: 0))

                
                
                /*
                
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
*/
            })
            
            /*
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
*/
            
            
            
            
            
            
        }
    }
}

struct PurchaseSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.data.operators.first!, product: ProductsData.shared.data.operators.first!.products!.first!)
        let purchaseSummareyViewModel = PurchaseSummaryViewModel(shoppingCart: shoppingCart)
        PurchaseSummaryView(viewModel: purchaseSummareyViewModel)
    }
}

