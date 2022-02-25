//
//  ContentView.swift
//  Shared
//
//  Created by Erik Fagerman on 2022-02-10.
//

import SwiftUI

class ProductsData {
    
    static let shared = ProductsData()
    
    var ticketOperators: [TicketOperator]
    
    private init() {
        
        let slPriceGroup1 = PriceGroup(id: "sl-adult", name: "Vuxen", price: 99)
        let slPriceGroup2 = PriceGroup(id: "sl-youth", name: "Rabbaterad", price: 33)
        let vtPriceGroup1 = PriceGroup(id: "vt-adult", name: "Vuxen", price: 99)
        let vtPriceGroup2 = PriceGroup(id: "vt-youth", name: "Barn", price: 33)

        let slProduct1 = ProductType(id: "sl-enkel", name: "SL Enkelbiljett", priceGroups: [slPriceGroup1.id, slPriceGroup2.id])
        let slProduct2 = ProductType(id: "sl-30", name: "SL 30 dagars", priceGroups: [slPriceGroup1.id, slPriceGroup1.id])
        let vtProduct1 = ProductType(id: "vt-enkel", name: "VT Enkelbiljett", priceGroups: [vtPriceGroup1.id, vtPriceGroup2.id])
        let vtProduct2 = ProductType(id: "vt-30", name: "VT 30 dagars", priceGroups: [vtPriceGroup2.id, vtPriceGroup2.id])


        let slTicketOperator = TicketOperator(id: "sl", name: "SL", productTypes: [slProduct1, slProduct2], priceGroups: [slPriceGroup1, slPriceGroup2], image: Image(systemName: "tortoise.fill"))
        let vtTicketOperator = TicketOperator(id: "vt", name: "Västtrafik", productTypes: [vtProduct1, vtProduct2], priceGroups: [vtPriceGroup1, vtPriceGroup2], image: Image(systemName: "hare"))

        self.ticketOperators = [slTicketOperator, vtTicketOperator]
    }
}


struct ContentView: View {
    
    let inactiveTicketViewModel = InactiveTicketViewModel(ticketModel: TicketModel())
    let inactiveFlexTicketViewModel = InactiveFlexTicketViewModel(ticketModel: TicketModel())
    let activeTicketViewModel = ActiveTicketViewModel(ticketModel: TicketModel())
    let activeFlexTicketViewModel = ActiveFlexTicketViewModel(ticketModel: TicketModel())
    
    let historicalTicket1 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Vuxen")
    let historicalTicket2 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")
    let historicalTicket3 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")
    let historicalTicket4 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")
    
    
    @State private var showingSheet = false
    
    var body: some View {
        
//        let ticketsViewModel = TicketsTabViewModel(ticketViewModels: [inactiveTicketViewModel, inactiveFlexTicketViewModel, activeTicketViewModel, activeFlexTicketViewModel])
//
//                Button("Show Tickets Sheet") {
//                    showingSheet.toggle()
//                }
//                .sheet(isPresented: $showingSheet) {
//                    TicketsTabView(ticketsViewModel: ticketsViewModel)
//
//                }
        
    
        let viewModel = SelectTicketTypeViewModel(historicalTickets: [historicalTicket1, historicalTicket2, historicalTicket3, historicalTicket4], ticketOperators: ProductsData.shared.ticketOperators)

        SelectTicketTypeSwiftUIView(viewModel: viewModel)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
