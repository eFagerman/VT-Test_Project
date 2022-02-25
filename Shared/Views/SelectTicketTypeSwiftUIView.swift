//
//  SelectTicketTypeSwiftUIView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-21.
//

import SwiftUI

protocol TicketHistory {
    
    var operatorImage: Image { get }
    var ticketName: String { get }
    var priceCategory: String { get }
}


struct HistoricalTicketSwiftUIView<TicketHistoryViewModel>: View where TicketHistoryViewModel: TicketHistory {
    
    var viewModel: TicketHistoryViewModel
    
    var body: some View {
        
        VStack(alignment: .alignItems) {
            
            HStack(spacing: 8) {
                viewModel.operatorImage
                    .alignmentGuide(.alignItems, computeValue: { d in
                        return d[HorizontalAlignment.leading]
                    })
                Text(viewModel.ticketName)
                    .font(.applicationFont(withWeight: .bold, andSize: 15))
            }
            
            Text(viewModel.priceCategory)
                .font(.applicationFont(withWeight: .regular, andSize: 15))
                .alignmentGuide(.alignItems, computeValue: { d in
                    return d[HorizontalAlignment.leading]
                })
        }
        .frame(width: 132, height: 67, alignment: .center)
        .background(Color.green)
        .cornerRadius(9.0)
    }
}






protocol SelectTicketData: ObservableObject {
    
    var title: String { get }
    var historySectionHeader: String { get }
    var operatorSectionHeader: String { get }
    var selectTicketTypeSectionHeader: String { get }
    
    var historicalTickets: [TicketHistory] { get set }
    
    var ticketOperators: [TicketOperator] { get set }
    
    var selectedOperator: TicketOperator { get set }
    
}


extension ProductType: SelectableItem {
    
    var title: String {
        self.name
    }
}

extension TicketOperator: SelectableItem {
    var title: String {
        self.name
    }
}

//struct SelectTicketTypeSwiftUIView<SelectTicketViewModel>: View where SelectTicketViewModel: SelectTicketData {
struct SelectTicketTypeSwiftUIView: View {
    
    @ObservedObject var viewModel: SelectTicketTypeViewModel
    @State private var isExpanded = false
    @State private var selectedOperator: TicketOperator? = nil
    @State private var selectedProduct: ProductType? = nil
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                // HISTORY
                Section(header: Text(viewModel.historySectionHeader)) {
                    
                    ScrollView(.horizontal) {
                        
                        HStack(spacing: 8) {
                            
                            ForEach(viewModel.historicalTickets, id: \.ticketName) { historicalTicket in
                                
                                let viewModel = HistoricalTicket(operatorImage: historicalTicket.operatorImage, ticketName: historicalTicket.ticketName, priceCategory: historicalTicket.priceCategory)
                                
                                HistoricalTicketSwiftUIView(viewModel: viewModel)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                    .frame(height: 67, alignment: .leading)
                    
                }
                
                // OPERATOR
                Section(header: Text(viewModel.operatorSectionHeader)) {
                    
                    DisclosureGroup(selectedOperator?.name ?? "", isExpanded: $isExpanded) {
                        
                        ForEach(viewModel.ticketOperators) { ticketOperator in
                            
                            SelectableRow(image: ticketOperator.image, title: ticketOperator.name, item: ticketOperator, selectedItem: $selectedOperator)
                                .onChange(of: selectedOperator) { newValue in
                                    isExpanded = false
                                }
                        }
                    }
                }
                
                // PRODUCT
                Section(header: Text(viewModel.selectTicketTypeSectionHeader)) {
        
                    if let selectedOperator = selectedOperator, let productTypes = selectedOperator.productTypes {
                        
                        ForEach(productTypes) { productType in
                            let shoppingCart = ShoppingCart(ticketOperator: selectedOperator, productType: productType)
                            NavigationLink(destination: SelectPriceCategorySwiftUIView(shoppingCart: shoppingCart)) {
                                Text(productType.name)
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .padding(.top)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Stäng") {
                        print("Help tapped!")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Info") {
                        print("Help tapped!")
                    }
                }
            }
            .onAppear {
                self.selectedOperator = viewModel.ticketOperators.first!
            }
        }
    }
}


//struct SelectTicketTypeSwiftUIView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//        let priceClass1 = PriceClass(name: "Vuxen", price: 99)
//        let priceClass2 = PriceClass(name: "Barn", price: 33)
//        
////        let product1 = Product(name: "SL Enkelbiljett", priceClasses: [priceClass1, priceClass2], operatorName: "SL", operatorImage: Image(systemName: "tortoise.fill"))
////
////        let product2 = Product(name: "SL 30 dagars", priceClasses: [priceClass1, priceClass2], operatorName: "SL", operatorImage: Image(systemName: "tortoise.fill"))
////
////        let product3 = Product(name: "VT Enkelbiljett", priceClasses: [priceClass1, priceClass2], operatorName: "Västtrafik", operatorImage: Image(systemName: "hare"))
////
////        let product4 = Product(name: "VT 30 dagars", priceClasses: [priceClass1, priceClass2], operatorName: "Västtrafik", operatorImage: Image(systemName: "hare"))
////
//        let product1 = Product(name: "SL Enkelbiljett", priceClasses: [priceClass1, priceClass2], operatorName: "SL")
//        
//        let product2 = Product(name: "SL 30 dagars", priceClasses: [priceClass1, priceClass2], operatorName: "SL")
//        
//        let product3 = Product(name: "VT Enkelbiljett", priceClasses: [priceClass1, priceClass2], operatorName: "Västtrafik")
//        
//        let product4 = Product(name: "VT 30 dagars", priceClasses: [priceClass1, priceClass2], operatorName: "Västtrafik")
//       
//        
//        
//        let ticketOperator1 = TicketOperator(name: "SL", products: [product1, product2])
//        
//        let ticketOperator2 = TicketOperator(name: "Västtrafik", products: [product3, product4])
//        
//        let historicalTicket1 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Vuxen")
//        
//        let historicalTicket2 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")
//        
//        let historicalTicket3 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")
//        
//        let historicalTicket4 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")
//        
//        
//        let viewModel = SelectTicketTypeViewModel(historicalTickets: [historicalTicket1, historicalTicket2, historicalTicket3, historicalTicket4], ticketOperators: [ticketOperator1, ticketOperator2])
//        
//        SelectTicketTypeSwiftUIView(viewModel: viewModel)
//    }
//}
