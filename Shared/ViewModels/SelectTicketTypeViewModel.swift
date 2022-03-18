//
//  SelectTicketTypeViewModel.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-21.
//

import Foundation
import SwiftUI

struct HistoricalTicket: TicketHistory {
    var operatorImage: Image
    var ticketTypeName: String
    var priceGroupName: String
}

//class SelectTicketTypeViewModel: SelectTicketData, ObservableObject {
class SelectTicketTypeViewModel: ObservableObject {
    
    var title: String = "Köp biljett"
    var historySectionHeader: String = "Historik"
    var operatorSectionHeader: String = "Operatör"
    var selectTicketTypeSectionHeader: String = "Välj biljettyp"
    
    @Published var historicalTickets: [TicketHistory]
    @Published var ticketOperators: [ResponseOperator]
    @Published var selectedOperator: ResponseOperator?
  
    init(historicalTickets: [HistoricalTicket], ticketOperators: [ResponseOperator]) {
        self.historicalTickets = historicalTickets
        self.ticketOperators = ticketOperators
        self.selectedOperator = ticketOperators.first
    }
}
