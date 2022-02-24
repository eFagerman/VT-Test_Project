//
//  ContentView.swift
//  Shared
//
//  Created by Erik Fagerman on 2022-02-10.
//

import SwiftUI

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
        
        let priceClass1 = PriceClass(name: "Vuxen", price: 99)
        let priceClass2 = PriceClass(name: "Barn", price: 33)
        
        let product1 = Product(name: "SL Enkelbiljett", priceClasses: [priceClass1, priceClass2], operatorName: "SL")
        
        let product2 = Product(name: "SL 30 dagars", priceClasses: [priceClass1, priceClass2], operatorName: "SL")
        
        let product3 = Product(name: "VT Enkelbiljett", priceClasses: [priceClass1, priceClass2], operatorName: "Västtrafik")
        
        let product4 = Product(name: "VT 30 dagars", priceClasses: [priceClass1, priceClass2], operatorName: "Västtrafik")
        
        
        let ticketOperator1 = TicketOperator(name: "SL", products: [product1, product2])
        
        let ticketOperator2 = TicketOperator(name: "Västtrafik", products: [product3, product4])
        
        let historicalTicket1 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Vuxen")
        
        let historicalTicket2 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")
        
        let historicalTicket3 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")
        
        let historicalTicket4 = HistoricalTicket(operatorImage: Image(systemName: "heart.fill"), ticketName: "Enkelbiljett", priceCategory: "Barn")

        let viewModel = SelectTicketTypeViewModel(historicalTickets: [historicalTicket1, historicalTicket2, historicalTicket3, historicalTicket4], ticketOperators: [ticketOperator1, ticketOperator2])


        SelectTicketTypeSwiftUIView(viewModel: viewModel)

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
