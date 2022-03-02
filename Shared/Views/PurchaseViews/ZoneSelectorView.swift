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
    
    @Published var shoppingCart: ShoppingCart
    @Published var fromText: String
    @Published var toText: String
  
    init(shoppingCart: ShoppingCart) {
        self.shoppingCart = shoppingCart
        self.fromText = ""
        self.toText = ""
    }
}


struct ZoneSelectorView: View {
    
    @Environment(\.presentationMode) var presentation

    @ObservedObject var viewModel: ZoneSelectorViewModel

    
    var body: some View {
        VStack {
            
            List {
                
                // TICKET TYPE
                Section(header: ticketTypeSectionHeaderView()) {
                    Text(viewModel.shoppingCart.productType.name)
                }
                .textCase(nil)
                
                // ZONE SEARCH
                Section(header: Text(viewModel.zoneSearchSectionTitle)) {
                    HStack {
                        Image(systemName: "info.circle.fill").foregroundColor(.gray)
                        FirstResponderTextField(
                            placeholder: viewModel.placeholderText,
                            text: $viewModel.fromText
                        )
                    }
                    .frame(height: 45)
                    
                    HStack {
                        Image(systemName: "info.circle.fill").foregroundColor(.gray)
                        FirstResponderTextField(
                            placeholder: viewModel.placeholderText,
                            text: $viewModel.toText
                        )
                    }
                    .frame(height: 45)
                }
                .textCase(nil)
                .listRowBackground(Color.clear)


                // ZONE SELECTION
                Section(header: Text(viewModel.zoneSelectionSectionTitle)) {
                    Text("a")
                    
                }
                .textCase(nil)

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
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var becameFirstResponder = false

        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.text = text
        textField.font = UIFont(name: "Sk-Modernist-Regular", size: 17.0)
        textField.tintColor = UIColor.blue // UIColor.General.accentColor
        textField.textColor = UIColor.black // UIColor.Text.primary
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray /*UIColor.General.placeholderColor*/]
        )
        return textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }
}

