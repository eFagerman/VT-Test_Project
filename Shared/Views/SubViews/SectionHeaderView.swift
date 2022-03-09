//
//  SectionHeaderView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-09.
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String
    var changeButton = false
    let changeTitle = "Ändra"
    @Environment(\.presentationMode) var presentation

    var body: some View {
        HStack {
            Text(title)
                .font(.applicationFont(withWeight: .bold, andSize: 13))
            Spacer()
            if changeButton {
                Button(changeTitle) {
                    presentation.wrappedValue.dismiss()
                }
                .font(.applicationFont(withWeight: .regular, andSize: 13))
            }
        }
        .padding(.horizontal)
        .padding(.top, 24)
        .padding(.bottom, 1)
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(title: "Title")
    }
}
