//
//  Protocols.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-09.
//

import SwiftUI

protocol TicketHistory {
    
    var operatorImage: Image { get }
    var ticketTypeName: String { get }
    var priceGroupName: String { get }
}

protocol SelectTicketData: ObservableObject {
    
    var title: String { get }
    var historySectionHeader: String { get }
    var operatorSectionHeader: String { get }
    var selectTicketTypeSectionHeader: String { get }
    
    var historicalTickets: [TicketHistory] { get set }
    var ticketOperators: [ResponseOperator] { get set }
    var selectedOperator: ResponseOperator? { get set }
}
