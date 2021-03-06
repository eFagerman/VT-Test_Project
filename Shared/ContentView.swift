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
    
    
//    @State private var showingSheet = false
    @State private var showingBuyTicketSheet = true

    var body: some View {
        
        ZStack {
            
            Color(UIColor.General.backgroundTwo).edgesIgnoringSafeArea(.all)
            
            //        let ticketsViewModel = TicketsTabViewModel(ticketViewModels: [inactiveTicketViewModel, inactiveFlexTicketViewModel, activeTicketViewModel, activeFlexTicketViewModel])
            //
            //                Button("Show Tickets Sheet") {
            //                    showingSheet.toggle()
            //                }
            //                .sheet(isPresented: $showingSheet) {
            //                    TicketsTabView(ticketsViewModel: ticketsViewModel)
            //
            //
            
            Button {
                showingBuyTicketSheet.toggle()
            } label: {
                Text("Buy ticket")
                    .foregroundColor(Color(UIColor.Popup.title))
            }
            .sheet(isPresented: $showingBuyTicketSheet) {
                let viewModel = SelectTicketTypeViewModel()
                SelectTicketTypeView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
