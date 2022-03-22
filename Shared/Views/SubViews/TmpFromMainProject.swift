//
//  TmpFromMainProject.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-08.
//

import SwiftUI


class DefaultLocaleProvider {
    
    static let shared = DefaultLocaleProvider()
    
    let fallbackCode = "en"
    let availableCodes = ["en", "sv"]
    let code = "en"
}

typealias TranslationResources = [String: [String: String]]

protocol ContainsTextResources {
    var resources: TranslationResources? { get }
}
extension ContainsTextResources {
    private var defaultCode: String { return DefaultLocaleProvider.shared.fallbackCode }
    private var code: String {
        guard DefaultLocaleProvider.shared.availableCodes.contains(DefaultLocaleProvider.shared.code),
              resources?.keys.contains(DefaultLocaleProvider.shared.code) == true else {
                  return defaultCode
              }
        return DefaultLocaleProvider.shared.code
    }
    func localization(for key: String) -> String? {
        guard let localizationDictionary = resources?[code] else {
            return nil
        }
        return localizationDictionary[key]
    }
}

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

struct DividerInset: View {
    var inset = false
    var width = 64
    var tight = false
    var body: some View {
        if tight {
            Spacer().frame(height: 0)
        }
        Divider()
            .background(Color(UIColor.General.divider))
            .padding(EdgeInsets(top: 0, leading: inset ? CGFloat(width) : 0, bottom: 0, trailing: 0))
        if tight {
            Spacer().frame(height: 0)
        }
    }
}

struct DividerInset_Previews: PreviewProvider {
    static var previews: some View {
        DividerInset()
    }
}
