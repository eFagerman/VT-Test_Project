//
//  ProductsData.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-03-18.
//

import Foundation

class ProductsData: Decodable {

    static let shared = ProductsData()

    var data: OperatorsData

    private init() {

        self.data = JsonLoader.createModel("data", type: OperatorsData.self)!
    }
}


struct OperatorsData: Decodable {
    
    var operators: [ResponseOperator]
}


