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
                    .padding(.bottom, -1)

                Divider().background(Color(UIColor.red))
                    .padding(.top, 1)
                Spacer().frame(height: 0)
                VStack {
                    HStack {
                        Spacer().frame(width: 16)
                        Text(viewModel.shoppingCart.productType.name)
                            .font(.applicationFont(withWeight: .bold, andSize: 15))
                        Spacer()
                    }
                }
                .frame(height: 46)
                .background(Color(UIColor.white))
                Spacer().frame(height: 0)
                Divider().background(Color(UIColor.red))

                // ZONE SEARCH
                HStack {
                    Text(viewModel.zoneSearchSectionTitle)
                        .font(.applicationFont(withWeight: .bold, andSize: 13))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 1)
                
                ZStack {
                    
                    VStack {
                        
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
                                .font(.applicationFont(withWeight: .regular, andSize: 13))
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
                                .font(.applicationFont(withWeight: .regular, andSize: 15))
                            Spacer().frame(width: 13)
                        }
                        .frame(height: 45)
                        .background(viewModel.isToTextActive ? Color(UIColor.white) : Color(UIColor.blue))
                        .cornerRadius(3, corners: [.topLeft, .topRight])
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        
                    }
                    
                    Button(action: {
                        self.viewModel.isFromTextActive.toggle()
                        self.viewModel.isToTextActive.toggle()
                        let oldFromText = viewModel.fromText
                        let oldToText = viewModel.toText
                        self.viewModel.fromText = oldToText
                        self.viewModel.toText = oldFromText
                    }) {
                        HStack {
                            Spacer()
                            Image(systemName: "info.circle.fill").foregroundColor(.gray)
                                .frame(width: 26)
                            Spacer().frame(width: 15 + 8 + CGFloat(textMinWidth ?? 0)/2 - CGFloat(26)/2)
                        }
                    }

                }
                

                
                // ZONE SELECTION HEADER
                HStack {
                    Text(viewModel.zoneSelectionSectionTitle)
                        .font(.applicationFont(withWeight: .bold, andSize: 13))
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 1)

                // ZONE LIST

                Text("a")
                    .font(.applicationFont(withWeight: .regular, andSize: 17))

            }
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
            .font(.applicationFont(withWeight: .bold, andSize: 21))
        }
    }
    
    private func ticketTypeSectionHeaderView() -> some View {
        HStack {
            Text(viewModel.ticketTypeSectionTitle)
                .font(.applicationFont(withWeight: .bold, andSize: 13))
            Spacer()
            Button(viewModel.ticketTypeSectionÄndra) {
                presentation.wrappedValue.dismiss()
            }
            .font(.applicationFont(withWeight: .regular, andSize: 13))
        }
        .padding(.horizontal)
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
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isActive = false
            textField.backgroundColor = parent.inactiveBackgroundColor
            textField.textColor = parent.inactiveTextColor
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
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
