//
//  TmpFromMainProject.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-08.
//

import SwiftUI

struct RadioButtonView: View {

    let isSelected: Bool

    var body: some View {
        if isSelected {
            Image(systemName: "circle.circle")
                .renderingMode(.template)
                .foregroundColor(Color(UIColor.green))
                .padding(.horizontal, 16)
        } else {
            Image(systemName: "circle")
                .renderingMode(.template)
                .foregroundColor(Color(UIColor.white))
                .padding(.horizontal, 16)
        }
    }
    
}
