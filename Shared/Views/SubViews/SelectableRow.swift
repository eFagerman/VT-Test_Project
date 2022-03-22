//
//  SelectableRow.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-22.
//

import SwiftUI

protocol SelectableItem: Equatable {}

struct SelectableRow<Model>: View where Model: SelectableItem {
    
    var hideRadioButtons = false
    var image: Image?
    var title: String?
    
    var item: Model
    @Binding var selectedItem: Model?
    
    var body: some View {
        HStack {
            
            Spacer().frame(width: 16)

            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.0, height: 24.0)
            }

            Spacer().frame(width: 16)

            if let title = self.title {
                Text(title)
                    .foregroundColor(Color(UIColor.Popup.title))
                    .font(.applicationFont(withWeight: .bold, andSize: 15))
            }
            
            Spacer()
            
            if hideRadioButtons {}
            else if item == selectedItem {
                Image("checkboxesRadioChecked")
                    .frame(width: 18.0, height: 18.0)
            } else {
                Image("checkboxesIosUnchecked")
                    .frame(width: 18.0, height: 18.0)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.selectedItem = self.item
        }
    }
}
