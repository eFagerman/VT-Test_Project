//
//  ZoneSelectorView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-02-28.
//

import SwiftUI


class ZoneSelectorViewModel: ObservableObject {
    
    let ticketTypeSectionTitle = "Biljettyp"
    let ticketTypeSectionÄndra = "Ändra"
    let zoneSearchSectionTitle = "Sök zon"
    let zoneSelectionSectionTitle = "Välj zon"
    let placeholderText = "Ange adress eller plats"
    
    let activeBackgroundColor = UIColor.white
    let activeTextColor = UIColor.black
    let inactiveBackgroundColor = UIColor.blue
    let inactiveTextColor = UIColor.white

    @Published var shoppingCart: ShoppingCart
    @Published var fromText: String
    @Published var toText: String
    @Published var isFromTextActive = false
    @Published var isToTextActive = true
  
    init(shoppingCart: ShoppingCart) {
        self.shoppingCart = shoppingCart
        self.fromText = ""
        self.toText = ""
    }
}


struct ZoneSelectorView: View {
    
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel: ZoneSelectorViewModel
    @State private var textMinWidth: CGFloat?
    
    var body: some View {
        VStack {
            
            ScrollView {
                
                // TICKET TYPE
                ticketTypeSectionHeaderView()
                Text(viewModel.shoppingCart.productType.name)
                
                // ZONE SEARCH
                Text(viewModel.zoneSearchSectionTitle)
                HStack {
                    Spacer().frame(width: 8)
                    Image(systemName: "info.circle.fill").foregroundColor(.gray)
                    Spacer().frame(width: 8)
                    FirstResponderTextField(
                        placeholder: viewModel.placeholderText,
                        text: $viewModel.fromText,
                        isActive: $viewModel.isFromTextActive,
                        activeBackgroundColor: viewModel.activeBackgroundColor,
                        activeTextColor: viewModel.activeTextColor,
                        inactiveBackgroundColor: viewModel.inactiveBackgroundColor,
                        inactiveTextColor: viewModel.inactiveTextColor)
                    Spacer().frame(width: 8)
                    TextOfEqualWidth(text: "Från", minTextWidth: $textMinWidth)
                    Spacer().frame(width: 15)
                }
                .frame(height: 45)
                .background(viewModel.isFromTextActive ? Color(UIColor.white) : Color(UIColor.blue))
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .cornerRadius(3, corners: [.bottomLeft, .bottomRight])
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                Spacer().frame(height: 4)

                HStack {
                    Spacer().frame(width: 8)
                    Image(systemName: "info.circle.fill").foregroundColor(.gray)
                    Spacer().frame(width: 8)
                    FirstResponderTextField(
                        placeholder: viewModel.placeholderText,
                        text: $viewModel.toText,
                        isActive: $viewModel.isToTextActive,
                        activeBackgroundColor: viewModel.activeBackgroundColor,
                        activeTextColor: viewModel.activeTextColor,
                        inactiveBackgroundColor: viewModel.inactiveBackgroundColor,
                        inactiveTextColor: viewModel.inactiveTextColor)
                    Spacer().frame(width: 8)
                    TextOfEqualWidth(text: "Till", minTextWidth: $textMinWidth)
                    Spacer().frame(width: 15)
                }
                .frame(height: 45)
                .background(viewModel.isToTextActive ? Color(UIColor.white) : Color(UIColor.blue))
                .cornerRadius(3, corners: [.topLeft, .topRight])
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))

                
                // ZONE SELECTION
                Text(viewModel.zoneSelectionSectionTitle)
                Text("a")
                
            }
            .listStyle(GroupedListStyle())
            .padding(.top)
            .navigationTitle(viewModel.shoppingCart.ticketOperator.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Info was tapped")
                    } label: {
                        Image(systemName: "info.circle.fill")
                    }
                }
            }
            .background(Color.gray)

            
            Spacer()
            
            NavigationLink("Köp biljett") {
                SelectPriceCategorySwiftUIView(shoppingCart: viewModel.shoppingCart)
                    .navigationTitle("Köp biljett")
            }
        }
    }
    
    private func ticketTypeSectionHeaderView() -> some View {
        HStack {
            Text(viewModel.ticketTypeSectionTitle)
            Spacer()
            Button(viewModel.ticketTypeSectionÄndra) {
                presentation.wrappedValue.dismiss()
            }
        }
        .padding()
    }


}

struct ZoneSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneSelectorView(viewModel: ZoneSelectorViewModel(shoppingCart: ShoppingCart(ticketOperator: ProductsData.shared.vtTicketOperator, productType: ProductsData.shared.vtTicketOperator.productTypes[0])))
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
        @Binding var text: String
        @Binding var isActive: Bool
        var becameFirstResponder = false
        let activeBackgroundColor: UIColor?
        let activeTextColor: UIColor?
        let inactiveBackgroundColor: UIColor?
        let inactiveTextColor: UIColor?

        init(text: Binding<String>, isActive: Binding<Bool>, activeBackgroundColor: UIColor? = nil, activeTextColor: UIColor? = nil, inactiveBackgroundColor: UIColor? = nil, inactiveTextColor: UIColor? = nil) {
            self._text = text
            self._isActive = isActive
            self.activeBackgroundColor = activeBackgroundColor
            self.activeTextColor = activeTextColor
            self.inactiveBackgroundColor = inactiveBackgroundColor
            self.inactiveTextColor = inactiveTextColor
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            isActive = true
            textField.backgroundColor = activeBackgroundColor
            textField.textColor = activeTextColor
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            isActive = false
            textField.backgroundColor = inactiveBackgroundColor
            textField.textColor = inactiveTextColor
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isActive: $isActive, activeBackgroundColor: activeBackgroundColor, activeTextColor: activeTextColor, inactiveBackgroundColor: inactiveBackgroundColor, inactiveTextColor: inactiveTextColor)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.text = text
        textField.clearButtonMode = .always
        textField.font = UIFont(name: "Sk-Modernist-Regular", size: 17.0)
        textField.tintColor = UIColor.blue // UIColor.General.accentColor
        textField.backgroundColor = getBackgroundColor()
        textField.textColor = getTextColor()
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray /*UIColor.General.placeholderColor*/]
        )
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
        var textColor = UIColor.black // UIColor.Text.primary
        if isActive, let activeTextColor = activeTextColor  {
            textColor = activeTextColor
        } else if !isActive, let inactiveTextColor = inactiveTextColor  {
            textColor = inactiveTextColor
        }
        return textColor
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder, isActive == true {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }
}


struct TextOfEqualWidth: View {
    let text: String
    let minTextWidth: Binding<CGFloat?>
    
    var body: some View {
        Text(text).equalWidth(minTextWidth)
    }
}

struct EqualWidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct EqualWidth: ViewModifier {
    let width: Binding<CGFloat?>
    func body(content: Content) -> some View {
        content.frame(width: width.wrappedValue, alignment: .leading)
            .background(GeometryReader { proxy in
                Color.clear.preference(key: EqualWidthPreferenceKey.self, value: proxy.size.width)
            }).onPreferenceChange(EqualWidthPreferenceKey.self) { (value) in
                self.width.wrappedValue = max(self.width.wrappedValue ?? 0, value)
            }
    }
}

extension View {
    func equalWidth(_ width: Binding<CGFloat?>) -> some View {
        return modifier(EqualWidth(width: width))
    }
}
