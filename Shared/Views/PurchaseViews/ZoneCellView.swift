//
//  ZoneCellView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-07.
//

import SwiftUI

struct ZoneCellView: View {
    
    var viewModel: ZoneCellModel
    
    var body: some View {
        
        HStack {
            Spacer().frame(width: 16)
            VStack(alignment: .leading) {
                Spacer().frame(height: 12)
                Text(viewModel.title)
                    .foregroundColor(.black)
                    .font(.applicationFont(withWeight: .bold, andSize: 15))
                Spacer().frame(height: 4)
                Text(viewModel.message)                                            .foregroundColor(.blue)
                    .font(.applicationFont(withWeight: .regular, andSize: 13))
                Spacer().frame(height: 12)
            }
            Spacer()
            RadioButtonView(isSelected: viewModel.selected)
        }
        .background(Color(UIColor.gray))
        .opacity(viewModel.dimmed ? 0.5 : 1)
        .animation(.easeInOut)
        
    }
}

struct ZoneCellView_Previews: PreviewProvider {
    static var previews: some View {
        let zoneA = ZoneCellModel(title: "Zon A", message: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ", selected: false, dimmed: false)
        ZoneCellView(viewModel: zoneA)
    }
}
