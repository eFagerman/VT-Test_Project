//
//  SelectPriceCategoryView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-23.
//

import SwiftUI

class SelectPriceCategoryViewModel: ObservableObject {
    
    @Published var shoppingCart: ShoppingCart
    var selectedZoneId: String? = nil
    
    @Published var selectedValidityPeriodTitle: String
    let validityPeriodSeconds: [Int64]
    let validityPeriodTitles: [String]

    let ticketTypeTitle = "Biljettyp"
    let zoneTitle = "Zon"
    let priceClassTitle = "Prisklass"
    let buyTicketTitle = "Köp biljett"
    
    let validityDurationTitle = "Giltighetsperiod"
    
    init(shoppingCart: ShoppingCart, selectedZoneId: String? = nil) {
        self.shoppingCart = shoppingCart
        self.selectedZoneId = selectedZoneId
        var tmpValidityPeriodSeconds = [Int64]()
        var tmpValidityPeriodTitles = [String]()
        if let prices = shoppingCart.product.prices {
            for price in prices {
                tmpValidityPeriodSeconds.append(price.validityDuration ?? 0)
                let minutes = String((price.validityDuration ?? 0) / 60)
                let tmpValidityPeriodTitle = minutes + " minuter"
                tmpValidityPeriodTitles.append(tmpValidityPeriodTitle)
            }
        }
        self.validityPeriodSeconds = tmpValidityPeriodSeconds
        self.validityPeriodTitles = tmpValidityPeriodTitles
        self.selectedValidityPeriodTitle = tmpValidityPeriodTitles.first ?? ""
    }
}

struct SelectPriceCategoryView: View {
    
    @Environment(\.presentationMode) var presentation

    @ObservedObject var viewModel: SelectPriceCategoryViewModel
    
    init(viewModel: SelectPriceCategoryViewModel) {
        self.viewModel = viewModel
        // TODO: check if this changes UISegmentedControl in main project. Maybe we can unite the colors between them.
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.Popup.okeyActionButtonBackground
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.General.secondComplementBackground], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.Popup.okeyActionButtonBackground], for: .normal)
    }
    
    var body: some View {
        
        let buttonHeight = CGFloat(48)
        
        ZStack {
            
            VStack {
                Color(UIColor.General.backgroundTwo)
                Color(UIColor.Popup.okeyActionButtonBackground)
                    .frame(height: buttonHeight-10) // the height is to cover the bottom area on iPhone 10+ models and at the same time to not be visible above the bottom button on older models with straight bottom
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                ScrollView {
                    
                    // TICKET TYPE HEADER
                    SectionHeaderView(title: viewModel.ticketTypeTitle, changeButton: true)
                    
                    // TICKET TYPE CELL
                    SimpleCell(title: viewModel.shoppingCart.product.title)
                    
                    // ZONE
                    if let zones = viewModel.shoppingCart.product.zones, zones.count > 0 {
                        
                        // ZONE HEADER
                        SectionHeaderView(title: viewModel.zoneTitle, changeButton: true)
                        
                        Spacer().frame(height: 8)
                        
                        // ZONE CELL
                        ForEach(zones, id: \.id) { zone in
                            SimpleCell(title: zone.resources?["sv"]?["zone.title"] ?? "")
                        }
                        DividerTight()
                    }
                    
                    // PRICE CLASS
                    
                    SectionHeaderView(title: viewModel.priceClassTitle)
                    
                    Spacer().frame(height: 8)
                    
                    ForEach($viewModel.shoppingCart.items) { $item in
                        DividerTight()
                        PriceClassRow(shoppingCartItem: $item)
                    }
                    if viewModel.shoppingCart.items.count > 0 {
                        DividerTight()
                    }
                    
                    // SEGMENTED CONTROL FOR VALIDITY DURATION
                    
                    if viewModel.validityPeriodSeconds.count > 0 {
                        VStack {
                            SectionHeaderView(title: viewModel.validityDurationTitle)
                            Spacer().frame(height: 8)
                            Picker("", selection: $viewModel.selectedValidityPeriodTitle) {
                                ForEach(viewModel.validityPeriodTitles, id: \.self) {
                                    Text($0)
                                        .foregroundColor(.green)
                                }
                            }
                            .accentColor(.yellow)
                            .padding(.horizontal)
                            .pickerStyle(.segmented)
                        }
                    }
                    
                }
                .padding(.top)
                
                Spacer()
                
                VStack {
                    let viewModel2 = PurchaseSummaryViewModel(shoppingCart: viewModel.shoppingCart)
                    NavigationLink(destination: PurchaseSummaryView(viewModel: viewModel2)
                                    .navigationTitle(viewModel.buyTicketTitle)) {
                        HStack {
                            Spacer()
                            Text(viewModel.buyTicketTitle)
                                .foregroundColor(Color(UIColor.General.secondComplementBackground))
                            Spacer()
                        }
                        .frame(height: buttonHeight)
                    }
                                    .contentShape(Rectangle())
                                    .font(.applicationFont(withWeight: .bold, andSize: 21))
                }
                .background(Color(UIColor.Popup.okeyActionButtonBackground))
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigation)  {
                    Image(systemName: "arrow.left")
                        .renderingMode(.template)
                        .foregroundColor(Color(UIColor.General.accentColor))
                        .onTapGesture {
                            // code to dismiss the view
                            self.presentation.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text(viewModel.shoppingCart.ticketOperator.title)
                            .foregroundColor(Color(UIColor.Popup.title))
                            .font(.applicationFont(withWeight: .bold, andSize: 17))
                    }
                }
            }
        }
    }
}

struct SelectPriceCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        
        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.data.operators.first!, product: ProductsData.shared.data.operators.first!.productTypes!.first!)
        SelectPriceCategoryView(viewModel: SelectPriceCategoryViewModel(shoppingCart: shoppingCart))
    }
}
