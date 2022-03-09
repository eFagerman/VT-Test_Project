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
    
    var vtTicketOperator: TicketOperator
    var historicalTicket1: HistoricalTicket
    var historicalTicket2: HistoricalTicket
    var historicalTicket3: HistoricalTicket
    var historicalTicket4: HistoricalTicket
    var slProduct1: ProductType
    var slTicketOperator: TicketOperator
    
    private init() {
        
        let slPriceGroup1 = PriceGroup(id: "sl-adult", name: "Vuxen", price: 50)
        let slPriceGroup2 = PriceGroup(id: "sl-youth", name: "Rabbaterad", price: 25)
        let vtPriceGroup1 = PriceGroup(id: "vt-adult", name: "Vuxen", price: 40)
        let vtPriceGroup2 = PriceGroup(id: "vt-youth", name: "Barn", price: 20)

        self.slProduct1 = ProductType(id: "sl-enkel", name: "SL Enkelbiljett", priceGroups: [slPriceGroup1.id, slPriceGroup2.id])
        let slProduct2 = ProductType(id: "sl-30", name: "SL 30 dagars", priceGroups: [slPriceGroup1.id, slPriceGroup2.id])
        let vtProduct1 = ProductType(id: "vt-enkel", name: "VT Enkelbiljett", priceGroups: [vtPriceGroup1.id, vtPriceGroup2.id])
        let vtProduct2 = ProductType(id: "vt-30", name: "VT 30 dagars", priceGroups: [vtPriceGroup1.id, vtPriceGroup2.id])


        self.slTicketOperator = TicketOperator(id: "sl", name: "SL", productTypes: [slProduct1, slProduct2], zones: [Zone(id: "A")], priceGroups: [slPriceGroup1, slPriceGroup2], image: Image(systemName: "tortoise.fill"))
        self.vtTicketOperator = TicketOperator(id: "vt", name: "Västtrafik", productTypes: [vtProduct1, vtProduct2], zones: [Zone(id: "A"), Zone(id: "B"), Zone(id: "C"), Zone(id: "AB")], priceGroups: [vtPriceGroup1, vtPriceGroup2], image: Image(systemName: "hare"))

        self.ticketOperators = [slTicketOperator, vtTicketOperator]
        
        self.historicalTicket1 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketTypeName: "Enkelbiljett", priceGroupName: "Vuxen")
        self.historicalTicket2 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketTypeName: "Enkelbiljett", priceGroupName: "Barn")
        self.historicalTicket3 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketTypeName: "Enkelbiljett", priceGroupName: "Barn")
        self.historicalTicket4 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketTypeName: "Enkelbiljett", priceGroupName: "Barn")
    }
}


struct ContentView: View {
    
    let inactiveTicketViewModel = InactiveTicketViewModel(ticketModel: TicketModel())
    let inactiveFlexTicketViewModel = InactiveFlexTicketViewModel(ticketModel: TicketModel())
    let activeTicketViewModel = ActiveTicketViewModel(ticketModel: TicketModel())
    let activeFlexTicketViewModel = ActiveFlexTicketViewModel(ticketModel: TicketModel())
    
    
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
        
    
        let viewModel = SelectTicketTypeViewModel(historicalTickets: [ProductsData.shared.historicalTicket1, ProductsData.shared.historicalTicket2, ProductsData.shared.historicalTicket3, ProductsData.shared.historicalTicket4], ticketOperators: ProductsData.shared.ticketOperators)

        SelectTicketTypeView(viewModel: viewModel)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
