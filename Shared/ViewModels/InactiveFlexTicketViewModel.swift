//
//  InactiveTicketViewModel.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-13.
//

import Foundation
import SwiftUI

class InactiveFlexTicketViewModel: ObservableObject, InactiveFlexticket, GenericTicketViewModel {
    
    private let ticketModel: TicketModel
    
    private var timer: Timer? = nil
    
    init(ticketModel: TicketModel) {
        self.ticketModel = ticketModel
    }
    
    @Published private(set) var backgroundColor: Color = .blue
    @Published private(set) var priceCategoryColor: Color = .gray
    @Published private(set) var priceCategory: String = "1 Adult"
    @Published private(set) var operatorImage: Image = Image(systemName: "ticket")
    @Published private(set) var fakeAztecImage: Image = Image("fakeAztec")
    @Published private(set) var identifier: String = "1234 567890"
    @Published private(set) var type: String = "Day ticket"

    @Published private(set) var travelPeriodsRemainingTitle: String = "Biljetter kvar:"
    @Published private(set) var travelPeriodsRemaining: String = "6"
    @Published private(set) var lastActivationDay: String = "Aktivera inom 30 dagar"
    @Published private(set) var activateButtonTitle: String = "Aktivera dagsbiljett"
    
    var activateTicketHandler: (() -> Void)? = {
        print("Activate ticket")
    }
    
}
