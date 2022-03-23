//
//  SelectTicketTypeView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-21.
//

import SwiftUI

extension ResponseOperatorProductType: SelectableItem { }

extension ResponseOperator: SelectableItem { }

struct SelectTicketTypeView: View {
    
    @ObservedObject var viewModel: SelectTicketTypeViewModel
    @State private var isExpanded = false
    @State var pushActive = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Color(UIColor.General.backgroundTwo).edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    
                    // HISTORY
                    historySectionView()
                    
                    // OPERATOR
                    
                    // OPERATOR HEADER
                    SectionHeaderView(title: viewModel.operatorSectionHeader)
                    
                    Spacer().frame(height: 8)
                    
                    // OPERATOR CELLS
                    operatorCells()
                    
                    // PRODUCT
                    
                    // PRODUCT HEADER
                    SectionHeaderView(title: viewModel.selectTicketTypeSectionHeader)
                    
                    Spacer().frame(height: 8)

                    // PRODUCT CELLS
                    productCells()
                }
                .padding(.top)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            // få till att den stänger här
                        } label: {
                            Image("close")
                                .renderingMode(.template)
                                .foregroundColor(Color(UIColor.General.accentColor))
                                .frame(width: 24, height: 24)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text(viewModel.title)
                                .foregroundColor(Color(UIColor.Popup.title))
                                .font(.applicationFont(withWeight: .bold, andSize: 17))
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Info")
                        } label: {
                            Image("icons24SystemInfo")
                                .renderingMode(.template)
                                .foregroundColor(Color(UIColor.General.accentColor))
                                .frame(width: 24, height: 24)
                        }
                        Button("Info") {
                            print("Help tapped")
                        }
                    }
                }
            }
        }
    }
    
    private func productCells() -> some View {
        VStack {
            if let selectedOperator = viewModel.selectedOperator, let productTypes = selectedOperator.productTypes {
                DividerTight()
                ForEach(productTypes) { productType in
                    let shoppingCart = ShoppingCart(ticketOperator: selectedOperator, product: productType)
                    if productType.zones?.count ?? 0 > 1 {
                        NavigationLink(destination: SelectZoneView(viewModel: SelectZoneViewModel(shoppingCart: shoppingCart, zones: productType.zones))) {
                            arrowCell(title: productType.title)
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
                        NavigationLink(destination: SelectPriceCategoryView(viewModel: SelectPriceCategoryViewModel(shoppingCart: shoppingCart))) {
                            arrowCell(title: productType.title)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    if productType == productTypes.last {
                        DividerTight()
                    } else {
                        DividerInset(inset: true, width: 16, tight: true)
                    }
                }
            }
        }
    }
        
    private func operatorCells() -> some View {
        VStack {
            DividerTight()
            HStack {
                DisclosureGroup(
                    isExpanded: $isExpanded,
                    content: {
                        VStack {
                            DividerInset(inset: false, tight: true)
                            ForEach(viewModel.ticketOperators) { ticketOperator in
                                VStack {
                                    HStack {
                                        Spacer().frame(width: 40)
                                        SelectableRow(hideRadioButtons: true, image: ticketOperator.image, title: ticketOperator.title, item: ticketOperator, selectedItem: $viewModel.selectedOperator)
                                            .onChange(of: viewModel.selectedOperator) { newValue in
                                                withAnimation {
                                                    isExpanded = false
                                                }
                                            }
                                    }
                                    .frame(height: 46)
                                    if ticketOperator != viewModel.ticketOperators.last {
                                        DividerInset(inset: true, width: 97, tight: true)
                                    }
                                }
                            }
                        }
                    },
                    label: {
                        
                        HStack {
                            Spacer().frame(width: 16)
                            viewModel.selectedOperator?.image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.0, height: 24.0)
                            Spacer().frame(width: 16)
                            Text(viewModel.selectedOperator?.title ?? "")
                                .foregroundColor(Color(UIColor.Popup.title))
                                .font(.applicationFont(withWeight: .bold, andSize: 15))
                            Spacer()
                        }
                        .frame(height: 36)
                        
                    })
                    .accentColor(Color(UIColor.Text.label))
                Spacer().frame(width: 23)
            }
            .background(Color(UIColor.General.secondComplementBackground))
            DividerTight()
        }
    }
    
    private func arrowCell(title: String) -> some View {
        HStack {
            Spacer().frame(width: 16)
            Text(title)
                .font(.applicationFont(withWeight: .bold, andSize: 15))
            Spacer()
            Image("ic_chevron")
                .foregroundColor(Color(UIColor.Text.label))
            Spacer().frame(width: 14)
        }
        .foregroundColor(Color(UIColor.Popup.title))
        .frame(height: 46)
        .background(Color(UIColor.General.secondComplementBackground))
    }

    private func historySectionView() -> some View {
        VStack {
            SectionHeaderView(title: viewModel.historySectionHeader)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 4) {
                    
                    // TODO: change \.ticketTypeName to some kind of id that we get from the server
                    ForEach(viewModel.historicalTickets, id: \.ticketTypeName) { historicalTicket in
                        
                        let viewModel = HistoricalTicket(operatorImage: historicalTicket.operatorImage, ticketTypeName: historicalTicket.ticketTypeName, priceGroupName: historicalTicket.priceGroupName)
                        HistoricalTicketView(viewModel: viewModel)
                            .onTapGesture {
                                pushActive = true
                            }
                        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.data.operators.first!, product: ProductsData.shared.data.operators.first!.productTypes!.first!)
                        let purchaseSummareyViewModel = PurchaseSummaryViewModel(shoppingCart: shoppingCart)
                        NavigationLink(destination: PurchaseSummaryView(viewModel: purchaseSummareyViewModel), isActive: $pushActive) {
                        }.hidden()
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 12))
            }
            .frame(height: 67, alignment: .leading)
        }
    }
}

struct SelectTicketTypeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = SelectTicketTypeViewModel()
        SelectTicketTypeView(viewModel: viewModel)
    }
}
