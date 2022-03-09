//
//  HistoricalTicketView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-09.
//

import SwiftUI

struct HistoricalTicketView<TicketHistoryViewModel>: View where TicketHistoryViewModel: TicketHistory {
    
    var viewModel: TicketHistoryViewModel
    
    var body: some View {
        
        VStack(alignment: .alignItems) {
            
            HStack(spacing: 8) {
                viewModel.operatorImage
                    .alignmentGuide(.alignItems, computeValue: { d in
                        return d[HorizontalAlignment.leading]
                    })
                Text(viewModel.ticketTypeName)
                    .font(.applicationFont(withWeight: .bold, andSize: 15))
            }
            
            Text(viewModel.priceGroupName)
                .font(.applicationFont(withWeight: .regular, andSize: 15))
                .alignmentGuide(.alignItems, computeValue: { d in
                    return d[HorizontalAlignment.leading]
                })
        }
        .frame(width: 132, height: 67, alignment: .center)
        .background(Color.green)
        .cornerRadius(9.0)
    }
}

struct HistoricalTicketView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalTicketView(viewModel: ProductsData.shared.historicalTicket1)
    }
}
