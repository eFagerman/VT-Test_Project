//
//  SelectableRow.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-22.
//

import SwiftUI

protocol SelectableItem: Equatable {}

struct SelectableRow<Model>: View where Model: SelectableItem {
    
    var image: Image?
    var title: String?
    
    var item: Model
    @Binding var selectedItem: Model?
    
    var body: some View {
        HStack {
            
            image
            
            if let title = self.title {
                Text(title)
            }
            
            Spacer()
            
            if item == selectedItem {
                Image("checkboxesRadioChecked")
            } else {
                Image("checkboxesIosUnchecked")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.selectedItem = self.item
        }
    }
}

struct PriceClassRow: View  {
        
    @Binding var shoppingCartItem: ShoppingCartItem
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(shoppingCartItem.priceGroup.name).font(.applicationFont(withWeight: .bold, andSize: 15))
                Text(String(shoppingCartItem.priceGroup.price)).font(.applicationFont(withWeight: .regular, andSize: 13))
            }
            
            Spacer()
            
            Stepper(String(shoppingCartItem.number), value: $shoppingCartItem.number, in: 0...100)
                .frame(width: 120, alignment: .leading)
                .font(.applicationFont(withWeight: .bold, andSize: 17))
            
        }
        .background(Color.clear)
    }
}
