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
    
    var body: some View {
        
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
                        DividerTight()
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
                            }
                        }
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
                        Spacer()
                    }
                    .frame(height: 48)
                }
                .contentShape(Rectangle())
                .font(.applicationFont(withWeight: .bold, andSize: 21))
            }
            .background(Color.yellow)
            .padding(EdgeInsets(top: -8, leading: 0, bottom: -12, trailing: 0))
           
        }
        .navigationTitle(viewModel.shoppingCart.ticketOperator.title)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.bottom, -8)
        .toolbar {
            ToolbarItem (placement: .navigation)  {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        // code to dismiss the view
                        self.presentation.wrappedValue.dismiss()
                    }
            }
        }
        
    }
}

struct SelectPriceCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        
        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.data.operators.first!, product: ProductsData.shared.data.operators.first!.products!.first!)
        SelectPriceCategoryView(viewModel: SelectPriceCategoryViewModel(shoppingCart: shoppingCart))
    }
}
