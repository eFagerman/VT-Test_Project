//
//  DividerTight.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-09.
//

import SwiftUI

struct DividerTight: View {
    var body: some View {
        Spacer()
            .frame(height: 0)
        Divider()
            .background(Color(UIColor.General.divider))
        Spacer()
            .frame(height: 0)
    }
}

struct DividerTight_Previews: PreviewProvider {
    static var previews: some View {
        DividerTight()
    }
}
