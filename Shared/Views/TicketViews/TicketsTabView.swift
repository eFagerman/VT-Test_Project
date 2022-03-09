//
//  TicketsTabView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-11.
//

import SwiftUI

protocol GenericTicketViewModel {}

class TicketsTabViewModel: ObservableObject {
   
    init(ticketViewModels: [GenericTicketViewModel]) {
        self.viewModels = ticketViewModels
    }
    
    @Published private(set) var viewModels: [GenericTicketViewModel]
}


struct TicketsTabView: View {
    
    @ObservedObject var ticketsViewModel: TicketsTabViewModel
    
    var body: some View {
        
        TabView {
            
            ForEach(0..<ticketsViewModel.viewModels.count) { index in
                        
                if let viewModel = ticketsViewModel.viewModels[index] as? InactiveTicketViewModel {
                    InactiveTicketView(viewModel: viewModel)

                } else if let viewModel = ticketsViewModel.viewModels[index] as? InactiveFlexTicketViewModel {
                    InactiveFlexTicketView(viewModel: viewModel)

                } else if let viewModel = ticketsViewModel.viewModels[index] as? ActiveTicketViewModel {
                    ActiveTicketView(viewModel: viewModel)

                } else if let viewModel = ticketsViewModel.viewModels[index] as? ActiveFlexTicketViewModel {
                    ActiveFlexTicketView(viewModel: viewModel)
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .edgesIgnoringSafeArea(.all)
    }
}

//struct TicketsTabView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TicketsTabView(ticketsViewModel: <#TicketsViewModel#>)
//    }
//}
