//
//  PurchaseSummarySwiftUIView.swift
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
    
    init(shoppingCart: ShoppingCart) {
        self.shoppingCart = shoppingCart
    }
}


struct TicketInfoSwiftUIView: View {
    
    var shoppingCartItems: [ShoppingCartItem]
    
    var body: some View {
        
        VStack {
            ForEach(shoppingCartItems) { shoppingCartItem in
                
                let number = String(shoppingCartItem.number)
                let priceClassName = shoppingCartItem.priceGroup.name
                let price = String(shoppingCartItem.priceGroup.price) + " " + shoppingCartItem.priceGroup.currency
                
                HStack {
                    Text(number + " " + priceClassName)
                    Spacer()
                    Text(price)
                }.font(.applicationFont(withWeight: .regular, andSize: 15))
            }
        }
    }
}


struct PurchaseSummarySwiftUIView: View {
    
    @ObservedObject var viewModel: PurchaseSummaryViewModel
    
    @State var selectablePaymentMethod: PaymentMethod? = nil
    
    var body: some View {
        
        VStack {
            
            
            // TICKET
            List {
                
                Section(header: Text("Din biljett")
                            .padding(.leading, -16)
                            .font(.applicationFont(withWeight: .bold, andSize: 13)),
                        footer: Text("Foooooter")
                            .padding(.leading, -16)
                            .font(.applicationFont(withWeight: .regular, andSize: 13))) {
                    
                    ImageTextRow(image: viewModel.shoppingCart.ticketOperator.image, text: viewModel.shoppingCart.ticketOperator.name)
                    
                    TicketInfoSwiftUIView(shoppingCartItems: viewModel.shoppingCart.items)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Summa:").font(.applicationFont(withWeight: .bold, andSize: 17))
                            Text("Moms").font(.applicationFont(withWeight: .regular, andSize: 15))
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text(viewModel.shoppingCart.totalPriceWithCurrency).font(.applicationFont(withWeight: .bold, andSize: 17))
                            Text("4,2 kr").font(.applicationFont(withWeight: .regular, andSize: 15))
                        }
                    }
                }
            }
            .listStyle(.automatic)
            .padding(.top)
            
            
            
            // PAYMENT METHOD
            List {
                
                Section(header: Text("Välj betalmetod").font(.applicationFont(withWeight: .bold, andSize: 13))) {
                    
                    ForEach(viewModel.paymentMethods, id: \.self) { paymentMetod in
                        SelectableRow(image: paymentMetod.image, title: paymentMetod.name, item: paymentMetod, selectedItem: $selectablePaymentMethod)
                    }
                }
            }
            .listStyle(.grouped)
            
            Spacer()
            
            Button("Betala") {
                
            }
            
        }
    }
}

//struct PurchaseSummarySwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        PurchaseSummarySwiftUIView()
//    }
//}
