//
//  SelectTicketTypeView.swift
//  TicketTest
//
//  Created by Erik Fagerman on 2022-02-21.
//

import SwiftUI

extension ProductType: SelectableItem {
    
    var title: String {
        self.name
    }
}

extension TicketOperator: SelectableItem {
    var title: String {
        self.name
    }
}

//struct SelectTicketTypeView<SelectTicketViewModel>: View where SelectTicketViewModel: SelectTicketData {
struct SelectTicketTypeView: View {
    
    @ObservedObject var viewModel: SelectTicketTypeViewModel
    @State private var isExpanded = false
    @State private var selectedOperator: TicketOperator? = nil
    @State private var selectedProduct: ProductType? = nil
    @State var pushActive = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                // HISTORY
                historySectionView()
                
                // OPERATOR
                
                // OPERATOR HEADER
                SectionHeaderView(title: viewModel.operatorSectionHeader)
                
                // OPERATOR CELLS
                HStack {
                    DisclosureGroup(
                        isExpanded: $isExpanded,
                        content: {
                            ForEach(viewModel.ticketOperators) { ticketOperator in
                                VStack {
                                    SelectableRow(image: ticketOperator.image, title: ticketOperator.name, item: ticketOperator, selectedItem: $selectedOperator)
                                        .frame(height: 46)
                                        .onChange(of: selectedOperator) { newValue in
                                            isExpanded = false
                                        }
                                    Divider()
                                }
                            }
                        },
                        label: {
                            VStack {
                                Divider()
                                HStack {
                                    Spacer().frame(width: 16)
                                    selectedOperator?.image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.0, height: 24.0)
                                    Spacer().frame(width: 16)
                                    Text(selectedOperator?.name ?? "")
                                    Spacer()
                                }
                                .frame(height: 46)
                                Divider()
                            }
                        })
                    Spacer().frame(width: 23)
                }
                
                // PRODUCT
                
                // PRODUCT HEADER
                SectionHeaderView(title: viewModel.selectTicketTypeSectionHeader)
                
                // PRODUCT CELLS
                if let selectedOperator = selectedOperator, let productTypes = selectedOperator.productTypes {
                    ForEach(productTypes) { productType in
                        let shoppingCart = ShoppingCart(ticketOperator: selectedOperator, productType: productType)
                        if selectedOperator.zones.count > 1 {
                            NavigationLink(destination: ZoneSelectorView(viewModel: ZoneSelectorViewModel(shoppingCart: shoppingCart))) {
                                arrowCell(title: productType.name)
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else {
                            NavigationLink(destination: SelectPriceCategoryView(viewModel: SelectPriceCategoryViewModel(shoppingCart: shoppingCart))) {
                                arrowCell(title: productType.name)
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
            .onAppear {
                if let ticketOperator = viewModel.ticketOperators.last { // tmp
                    self.selectedOperator = ticketOperator
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
        .frame(height: 48)
        .background(Color(UIColor.gray))
    }

    private func historySectionView() -> some View {
        VStack {
            SectionHeaderView(title: viewModel.historySectionHeader)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 8) {
                    
                    ForEach(viewModel.historicalTickets, id: \.ticketTypeName) { historicalTicket in
                        
                        let viewModel = HistoricalTicket(operatorImage: historicalTicket.operatorImage, ticketTypeName: historicalTicket.ticketTypeName, priceGroupName: historicalTicket.priceGroupName)
                        HistoricalTicketView(viewModel: viewModel)
                            .onTapGesture {
                                pushActive = true
                            }
                        let shoppingCart = ShoppingCart(ticketOperator: ProductsData.shared.slTicketOperator, productType: ProductsData.shared.slProduct1)
                        let viewModel = PurchaseSummaryViewModel(shoppingCart: shoppingCart)
                        NavigationLink(destination: PurchaseSummaryView(viewModel: viewModel), isActive: $pushActive) {
                        }.hidden()
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            .frame(height: 67, alignment: .leading)
        }
    }
}

struct SelectTicketTypeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SelectTicketTypeViewModel(historicalTickets: [ProductsData.shared.historicalTicket1, ProductsData.shared.historicalTicket2, ProductsData.shared.historicalTicket3, ProductsData.shared.historicalTicket4], ticketOperators: ProductsData.shared.ticketOperators)
        SelectTicketTypeView(viewModel: viewModel)
    }
}
