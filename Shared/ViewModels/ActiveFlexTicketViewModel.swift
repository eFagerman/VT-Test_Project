//
//  ActiveFlexTicketViewModel.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-15.
//

import Foundation
import SwiftUI

class ActiveFlexTicketViewModel: ObservableObject, ActiveFlexTicket, GenericTicketViewModel {
    
    private let ticketModel: TicketModel
    private var timer: Timer? = nil
    
    init(ticketModel: TicketModel) {
        self.ticketModel = ticketModel
        setupTimer()
    }
    
    @Published private(set) var backgroundColor: Color = .green
    @Published private(set) var priceCategoryColor: Color = .gray
    @Published private(set) var priceCategory: String = "1 Vuxen"
    @Published private(set) var operatorImage: Image = Image(systemName: "heart.fill")
    @Published private(set) var aztecImage: Image = Image("fakeAztec")
    @Published private(set) var identifier: String = "1234 567890"
    @Published private(set) var type: String = "10/30"
    @Published private(set) var timeLeftTitle: String = "Tid kvar:"
    @Published private(set) var timeLeft: String = ""
    
    @Published private(set) var travelPeriodsRemainingTitle: String = "Biljetter kvar:"
    @Published private(set) var travelPeriodsRemaining: String = "6 st"
    @Published private(set) var validityDateTitle: String = "Giltiga till:"
    @Published private(set) var validityDate: String = "Mån 28 Feb"
    
    private func setupTimer() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let time = Int(self.ticketModel.expireDate.timeIntervalSinceNow)
            self.timeLeft = String(time)
        }
    }
}
