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
            image
            Text(text)
            Spacer()
        }
    }
}

//struct ImageWithTextRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageWithTextRow()
//    }
//}
