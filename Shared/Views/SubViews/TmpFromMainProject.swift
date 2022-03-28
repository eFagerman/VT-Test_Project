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
            Image("checked")
                .renderingMode(.template)
                .foregroundColor(Color(UIColor.accentGreen))
                .padding(.horizontal, 16)
        } else {
            Image("unchecked")
                .renderingMode(.template)
                .foregroundColor(Color(UIColor.darkSecondaryPowderBlue50))
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

struct FirstResponderTextField: UIViewRepresentable {
    
    let placeholder: String
    @Binding var text: String
    @Binding var isActive: Bool
    let activeBackgroundColor: UIColor?
    let activeTextColor: UIColor?
    let inactiveBackgroundColor: UIColor?
    let inactiveTextColor: UIColor?
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        var parent: FirstResponderTextField
        
        init(_ parent: FirstResponderTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.isActive = true
            textField.backgroundColor = parent.activeBackgroundColor
            textField.textColor = parent.activeTextColor
            textField.attributedPlaceholder = NSAttributedString(
                string: parent.placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.Text.searchFieldActivePlaceholder]
            )
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isActive = false
            textField.backgroundColor = parent.inactiveBackgroundColor
            textField.textColor = parent.inactiveTextColor
            textField.attributedPlaceholder = NSAttributedString(
                string: parent.placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.Text.searchFieldInactivePlaceholder]
            )
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.text = text
        textField.clearButtonMode = .always
        textField.font = UIFont(name: "Sk-Modernist-Regular", size: 17.0)
        textField.tintColor = UIColor.General.accentColor
        textField.backgroundColor = getBackgroundColor()
        textField.textColor = getTextColor()
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: isActive ? UIColor.Text.searchFieldActivePlaceholder : UIColor.Text.searchFieldInactivePlaceholder]
        )
        textField.tintColor = UIColor.baseMidnight
        if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
            let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(templateImage, for: .normal)
            clearButton.tintColor = UIColor.General.locationIconTintColor
        }
        return textField
    }
    
    func getBackgroundColor() -> UIColor {
        var backgroundColor = UIColor.clear
        if isActive, let activeBackgroundColor = activeBackgroundColor  {
            backgroundColor = activeBackgroundColor
        } else if !isActive, let inactiveBackgroundColor = inactiveBackgroundColor  {
            backgroundColor = inactiveBackgroundColor
        }
        return backgroundColor
    }

    func getTextColor() -> UIColor {
        var textColor = UIColor.Text.primary
        if isActive, let activeTextColor = activeTextColor  {
            textColor = activeTextColor
        } else if !isActive, let inactiveTextColor = inactiveTextColor  {
            textColor = inactiveTextColor
        }
        return textColor
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let textField = uiView as? UITextField {
            textField.text = text
            if isActive == true {
                textField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
    }
}



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
