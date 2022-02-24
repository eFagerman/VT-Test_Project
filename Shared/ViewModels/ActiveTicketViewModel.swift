//
//  ActiveTicketViewModel.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-13.
//

import Foundation
import SwiftUI

class ActiveTicketViewModel: ObservableObject, ActiveTicket, GenericTicketViewModel {
    
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
    @Published private(set) var type: String = "Singelbiljett"
    @Published private(set) var timeLeftTitle: String = "Tid kvar:"
    @Published private(set) var timeLeft: String = ""
    
    private func setupTimer() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let time = Int(self.ticketModel.expireDate.timeIntervalSinceNow)
            self.timeLeft = String(time)
        }
    }
    
}
