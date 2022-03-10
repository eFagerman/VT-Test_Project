//
//  ImageWithTextRow.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-24.
//

import SwiftUI

struct ImageTextRow: View {
    
    var image: Image
    var text: String
    
    var body: some View {
        
        HStack {
            Spacer().frame(width: 16)
            image
                .frame(width: 24, height: 24)
            Spacer().frame(width: 8)
            Text(text)
                .font(.applicationFont(withWeight: .bold, andSize: 15))
            Spacer()
        }
    }
}

struct ImageTextRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageTextRow(image: Image(systemName: "bus"), text: "Bus")
            .background(Color.red)
    }
}
