//
//  SimpleCell.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-09.
//

import SwiftUI

struct SimpleCell: View {
    let title: String
    
    var body: some View {
        VStack {
            Divider()
                .background(Color(UIColor.General.divider))
                .padding(.top, 1)
            Spacer().frame(height: 0)
            VStack {
                HStack {
                    Spacer().frame(width: 16)
                    Text(title)
                        .font(.applicationFont(withWeight: .bold, andSize: 15))
                        .foregroundColor(Color(UIColor.Popup.title))
                    Spacer()
                }
            }
            .frame(height: 46)
            .background(Color(UIColor.General.secondComplementBackground))
            Spacer().frame(height: 0)
            Divider()
                .background(Color(UIColor.General.divider))
        }
    }
}

struct SimpleCell_Previews: PreviewProvider {
    static var previews: some View {
        SimpleCell(title: "Title")
    }
}
