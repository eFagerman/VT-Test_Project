//
//  StopCellView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-07.
//

import SwiftUI

struct StopCellView: View {
    
    var viewModel: SearchSuggestionModel
    
    var body: some View {
        
        HStack {
            Spacer().frame(width: 16)
            Image(systemName: viewModel.transportIconName)
                .frame(width: 24)
                .foregroundColor(Color(UIColor.Ticket.transportIconColor))
            Spacer().frame(width: 16)
            Text(viewModel.stopName)
                .font(.applicationFont(withWeight: .regular, andSize: 17))
                .foregroundColor(Color(UIColor.Popup.title))
            Spacer()
            Text(viewModel.areaName)
                .font(.applicationFont(withWeight: .regular, andSize: 12))
                .foregroundColor(Color(UIColor.Text.label))
            Spacer().frame(width: 16)
        }
        .frame(height: 48)
        .background(Color(UIColor.General.secondComplementBackground))
        .animation(.easeInOut)

    }
}

struct StopCellView_Previews: PreviewProvider {
    static var previews: some View {
        let searchModel = SearchSuggestionModel(transportIconName: "tram.fill", stopName: "Järntorget", areaName: "Göteborg")
        StopCellView(viewModel: searchModel)
    }
}
