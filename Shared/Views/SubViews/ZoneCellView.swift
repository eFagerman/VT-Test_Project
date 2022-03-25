//
//  ZoneCellView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-07.
//

import SwiftUI

struct ZoneCellView: View {
   
    var zone: ResponseOperatorZone
    @Binding var selectedZone: ResponseOperatorZone?
    
    var body: some View {
        
        HStack {
            Spacer().frame(width: 16)
            VStack(alignment: .leading) {
                Spacer().frame(height: 12)
                Text(zone.title)
                    .font(.applicationFont(withWeight: .bold, andSize: 15))
                    .foregroundColor(Color(UIColor.Popup.title))
                Spacer().frame(height: 4)
                //Text(viewModel.message)
                    .foregroundColor(Color(UIColor.Text.label))
                    .font(.applicationFont(withWeight: .regular, andSize: 13))
                Spacer().frame(height: 12)
            }
            Spacer()
            RadioButtonView(isSelected: zone.id == selectedZone?.id)
        }
        .background(Color(UIColor.General.secondComplementBackground))
        //.opacity(viewModel.dimmed ? 0.5 : 1)
        .animation(.easeInOut)
        
    }
}

//struct ZoneCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        let zoneA = ZoneCellModel(id: "", title: "Zon A", message: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ", selected: false, dimmed: false)
//        ZoneCellView(viewModel: zoneA)
//    }
//}
