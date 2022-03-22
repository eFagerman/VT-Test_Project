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
        
        VStack {
            
            Spacer()

            HStack {
                Spacer().frame(width: 14)
                viewModel.operatorImage
                    .alignmentGuide(.alignItems, computeValue: { d in
                        return d[HorizontalAlignment.leading]
                    })
                    .frame(width: 18, height: 18)
                
                Spacer().frame(width: 8)
                
                Text(viewModel.ticketTypeName)
                    .font(.applicationFont(withWeight: .bold, andSize: 15))
                    .foregroundColor(Color(UIColor.Popup.title))
                Spacer()
            }
            
            Spacer().frame(height: 7)

            
            HStack {
                Spacer().frame(width: 14)
                Text(viewModel.priceGroupName)
                    .font(.applicationFont(withWeight: .regular, andSize: 15))
                    .foregroundColor(Color(UIColor.Text.label))
                Spacer()
            }
            
            Spacer()

        }
        .frame(width: 132, height: 67)
        .background(Color(UIColor.HistoricalTicket.boxBackgroundColor))
        .cornerRadius(9)
    }
}

//struct HistoricalTicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoricalTicketView(viewModel: ProductsData.shared.historicalTicket1)
//    }
//}
