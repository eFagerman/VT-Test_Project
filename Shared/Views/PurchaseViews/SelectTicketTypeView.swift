//
//  SelectTicketTypeView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-21.
//

import SwiftUI

extension ResponseOperatorProduct: SelectableItem { }

extension ResponseOperator: SelectableItem { }

//struct SelectTicketTypeView<SelectTicketViewModel>: View where SelectTicketViewModel: SelectTicketData {
struct SelectTicketTypeView: View {
    
    @ObservedObject var viewModel: SelectTicketTypeViewModel
    @State private var isExpanded = true
    @State var pushActive = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                // HISTORY
                historySectionView()
                
                // OPERATOR
                
                // OPERATOR HEADER
                SectionHeaderView(title: viewModel.operatorSectionHeader)
                
                Spacer().frame(height: 8)
                
                // OPERATOR CELLS
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
                                                .foregroundColor(.white)
                                                .onChange(of: viewModel.selectedOperator) { newValue in
                                                    withAnimation {
                                                        isExpanded = true
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
                                    Spacer()
                                }
                                .frame(height: 36)
                                
                        })
                        .accentColor(.white)
                    Spacer().frame(width: 23)
                }
                .background(Color.blue)
                DividerTight()
                
                // PRODUCT
                
                // PRODUCT HEADER
                SectionHeaderView(title: viewModel.selectTicketTypeSectionHeader)
                
                // PRODUCT CELLS
                if let selectedOperator = viewModel.selectedOperator, let productTypes = selectedOperator.products {
                    ForEach(productTypes) { productType in
                        let shoppingCart = ShoppingCart(ticketOperator: selectedOperator, product: productType)
                        if selectedOperator.zones?.count ?? 0 > 1 {
                            NavigationLink(destination: SelectZoneView(viewModel: SelectZoneViewModel(shoppingCart: shoppingCart))) {
                                arrowCell(title: productType.title)
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else {
                            NavigationLink(destination: SelectPriceCategoryView(viewModel: SelectPriceCategoryViewModel(shoppingCart: shoppingCart))) {
                                arrowCell(title: productType.title)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        DividerTight()
                    }
                }
            }
            .padding(.top)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Close")
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Info")
                    } label: {
                        Image(systemName: "info.circle.fill")
                    }
                    Button("Info") {
                        print("Help tapped")
                    }
                }
            }
        }
    }
    
    private func arrowCell(title: String) -> some View {
        HStack {
            Spacer().frame(width: 16)
            Text(title)
                .font(.applicationFont(withWeight: .regular, andSize: 17))
            Spacer()
            Image(systemName: "chevron.compact.right")
            Spacer().frame(width: 14)
        }
        .foregroundColor(.white)
        .frame(height: 46)
        .background(Color(UIColor.gray))
    }

    private func historySectionView() -> some View {
        VStack {
            SectionHeaderView(title: viewModel.historySectionHeader)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 4) {
                    
                    ForEach(viewModel.historicalTickets, id: \.ticketTypeName) { historicalTicket in
                        
                        let viewModel = HistoricalTicket(operatorImage: historicalTicket.operatorImage, ticketTypeName: historicalTicket.ticketTypeName, priceGroupName: historicalTicket.priceGroupName)
                        HistoricalTicketView(viewModel: viewModel)
                            .onTapGesture {
                                pushActive = true
                            }
                        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.data.operators.first!, product: ProductsData.shared.data.operators.first!.products!.first!)
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
