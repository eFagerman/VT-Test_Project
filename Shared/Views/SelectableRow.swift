//
//  SelectableRow.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-22.
//

import SwiftUI

protocol SelectableItem: Identifiable, Equatable {
    
    var title: String { get }
}

struct SelectableRow<Model>: View where Model: SelectableItem {
    
    var item: Model
    @Binding var selectedItem: Model?
    
    var body: some View {
        HStack {
            Text(item.title)
            
            Spacer()
            if item == selectedItem {
                Image(systemName: "circle.fill")
            }
        }
        .background(Color.clear)
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
                Text(shoppingCartItem.priceClass.name).font(.applicationFont(withWeight: .bold, andSize: 15))
                Text(String(shoppingCartItem.priceClass.price)).font(.applicationFont(withWeight: .regular, andSize: 13))
            }
            
            Spacer()
            
            Stepper(String(shoppingCartItem.number), value: $shoppingCartItem.number, in: 0...100)
                .frame(width: 120, alignment: .leading)
                .font(.applicationFont(withWeight: .bold, andSize: 17))
            
        }
        .background(Color.clear)
    }
}
