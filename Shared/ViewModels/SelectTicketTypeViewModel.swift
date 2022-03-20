//
//  SelectTicketTypeViewModel.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-21.
//

import Foundation
import SwiftUI

enum OperatorsLoadingError: Error {
    
    case decodingError
}

protocol OperatorsService {
    
    func loadOperators() async throws -> [ResponseOperator]
}

struct MockOperatorsService: OperatorsService {
    
    func loadOperators() async throws -> [ResponseOperator] {
        
        Thread.sleep(forTimeInterval: 2)
        
        if let data = JsonLoader.createModel("data", type: OperatorsData.self) {
            return data.operators
        } else {
            throw OperatorsLoadingError.decodingError
        }
    }
}



struct HistoricalTicket: TicketHistory {
    var operatorImage: Image
    var ticketTypeName: String
    var priceGroupName: String
}

//class SelectTicketTypeViewModel: SelectTicketData, ObservableObject {
@MainActor final class SelectTicketTypeViewModel: ObservableObject {
    
    var title: String = "Köp biljett"
    var historySectionHeader: String = "Historik"
    var operatorSectionHeader: String = "Operatör"
    var selectTicketTypeSectionHeader: String = "Välj biljettyp"
    
    @Published var historicalTickets: [TicketHistory] = []
    @Published var ticketOperators: [ResponseOperator] = []
    @Published var selectedOperator: ResponseOperator?
    @Published var isLoading = false
    
    
    private let operatorsService: OperatorsService
    
    init(operatorsService: OperatorsService = MockOperatorsService()) {
        self.operatorsService = operatorsService
        self.selectedOperator = ticketOperators.first
        
        fetchOperators()
    }
    
    func fetchOperators() {
        
        Task.init {
            do {
                isLoading = true
                ticketOperators = try await operatorsService.loadOperators()
                selectedOperator = ticketOperators.first
                isLoading = false
                
            } catch {
                // .. handle error
            }
        }
    }
    
}
