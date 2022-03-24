//
//  ImageWithTextRow.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-24.
//

import SwiftUI
import SBPAsyncImage

struct ImageTextRow: View {
    
    var imageUrlString: String?
    var text: String
    
    var body: some View {
        
        HStack {
            Spacer().frame(width: 16)
            
            if let imageUrlString = imageUrlString {
                BackportAsyncImage(url: URL(string: imageUrlString)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(Color(UIColor.Popup.title))
                Spacer().frame(width: 8)
            }
            
            Text(text)
                .font(.applicationFont(withWeight: .bold, andSize: 15))
                .foregroundColor(Color(UIColor.Popup.title))
            
            Spacer()
        }
    }
}

struct ImageTextRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageTextRow(imageUrlString: "", text: "Bus")
            .background(Color.red)
    }
}
