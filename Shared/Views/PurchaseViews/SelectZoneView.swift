//
//  ZoneSelectorView.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-02-28.
//

import SwiftUI


struct ZoneCellModel {
    let id: String?
    let title: String
    let message: String
    var selected = false
    var dimmed = false
}

struct SearchSuggestionModel: Hashable {
    let transportIconName: String
    let stopName: String
    let areaName: String
}

class SelectZoneViewModel: ObservableObject {
    
    let ticketTypeSectionTitle = "Biljettyp"
    let zoneSearchSectionTitle = "Sök zon"
    let zoneSelectionSectionTitle = "Välj zon"
    let placeholderTitle = "Ange adress eller plats"
    let buyTicketTitle = "Köp biljett"
    let fromTitle = "Från"
    let toTitle = "Till"
    
    let activeBackgroundColor = UIColor.white
    let activeTextColor = UIColor.black
    let inactiveBackgroundColor = UIColor.blue
    let inactiveTextColor = UIColor.white

    @Published var shoppingCart: ShoppingCart
    @Published var fromText: String
    @Published var toText: String
    @Published var isFromTextActive = false
    @Published var isToTextActive = true
    @Published var zoneList: [ZoneCellModel]
    public var zones: [ResponseOperatorZone]?
    @Published var searchSuggestionList: [SearchSuggestionModel]
    public var selectedZoneId: String? = nil

    init(shoppingCart: ShoppingCart, zones: [ResponseOperatorZone]?) {
        self.shoppingCart = shoppingCart
        self.fromText = ""
        self.toText = ""
        self.zones = zones
        self.zoneList = SelectZoneViewModel.getZoneCellModelList(zones: zones)
        self.searchSuggestionList = SelectZoneViewModel.getSearchSuggestionModelList()
    }
    
    private static func getZoneCellModelList(zones: [ResponseOperatorZone]?) -> [ZoneCellModel] {
        guard var zones = zones else { return [] }
        zones.sort(by: { $0.sort ?? 0 < $1.sort ?? 0 })
        var zoneCellModelList = [ZoneCellModel]()
        for zone in zones {
            let selected = zone == zones.first
            let zoneCellModel = ZoneCellModel(id: zone.id, title: zone.resources?["sv"]?["zone.title"] ?? "Zone", message: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ", selected: selected, dimmed: false)
            zoneCellModelList.append(zoneCellModel)
        }
        return zoneCellModelList
    }
    
    private static func getSearchSuggestionModelList() -> [SearchSuggestionModel] {
        let searchSuggestion1 = SearchSuggestionModel(transportIconName: "tram.fill", stopName: "Järntorget", areaName: "Göteborg")
        let searchSuggestion2 = SearchSuggestionModel(transportIconName: "bus.fill", stopName: "Järntorget", areaName: "Göteborg")
        let searchSuggestion3 = SearchSuggestionModel(transportIconName: "mappin", stopName: "Järntorget", areaName: "Göteborg")
        return [searchSuggestion1, searchSuggestion2, searchSuggestion3]
    }

    func tappedOnZone(tappedIndex: Int) {
        var newZoneList = [ZoneCellModel]()
        var index = -1
        for zoneListItem in self.zoneList {
            index += 1
            var newZoneListItem = zoneListItem
            let selected = tappedIndex == index
            newZoneListItem.selected = selected
            newZoneList.append(newZoneListItem)
            if selected {
                selectedZoneId = zoneListItem.id
            }
        }
        self.zoneList = newZoneList
    }
    
    func tappedOnSearch(tappedIndex: Int) {
        toText = searchSuggestionList[tappedIndex].stopName
        self.searchSuggestionList.remove(at: tappedIndex)
    }

}


struct SelectZoneView: View {
    
    @Environment(\.presentationMode) var presentation

    @ObservedObject var viewModel: SelectZoneViewModel
    @State private var textMinWidth: CGFloat?
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.red)).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                ScrollView {
                    
                    // TICKET TYPE
                    SectionHeaderView(title: viewModel.ticketTypeSectionTitle, changeButton: true)
                    
                    SimpleCell(title: viewModel.shoppingCart.product.title)
                    
                    // ZONE SEARCH
                    zoneSearchView()
                    
                    // SEARCH SUGGESTIONS
                    ForEach(viewModel.searchSuggestionList, id: \.self) { searchSuggestion in
                        StopCellView(viewModel: searchSuggestion)
                            .onTapGesture {
                                viewModel.tappedOnSearch(tappedIndex: viewModel.searchSuggestionList.firstIndex(of: searchSuggestion) ?? 0)
                            }
                        if viewModel.searchSuggestionList.firstIndex(of: searchSuggestion) ?? -1 < viewModel.searchSuggestionList.count - 1 {
                            DividerTight()
                        }
                        
                    }
                    
                    // ZONE SELECTION HEADER
                    SectionHeaderView(title: viewModel.zoneSelectionSectionTitle)
                        .padding(.bottom, 4)
                    
                    // ZONE LIST
                    ForEach(viewModel.zoneList.indices) { i in
                        VStack {
                            ZoneCellView(viewModel: viewModel.zoneList[i])
                                .onTapGesture {
                                    viewModel.tappedOnZone(tappedIndex: i)
                                }
                            DividerTight()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .navigationTitle(viewModel.shoppingCart.ticketOperator.title)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .padding(.bottom, -8)
                .toolbar {
                    ToolbarItem (placement: .navigation)  {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .onTapGesture {
                                // code to dismiss the view
                                self.presentation.wrappedValue.dismiss()
                            }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Info was tapped")
                        } label: {
                            Image(systemName: "info.circle.fill")
                        }
                    }
                }
                .background(Color.red)
                
                VStack {
                    NavigationLink(destination: SelectPriceCategoryView(viewModel: SelectPriceCategoryViewModel(shoppingCart: viewModel.shoppingCart, selectedZoneId: viewModel.selectedZoneId))) {
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
                .padding(EdgeInsets(top: -8, leading: 0, bottom: 0, trailing: 0))
                
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: -12, trailing: 0))
            .background(Color.green)
        }
    }
    
    private func zoneSearchView() -> some View {
        VStack {
            SectionHeaderView(title: viewModel.zoneSearchSectionTitle)
            
            ZStack {
                
                VStack {
                    
                    HStack {
                        Spacer().frame(width: 8)
                        Image(systemName: "info.circle.fill").foregroundColor(.gray)
                        Spacer().frame(width: 8)
                        FirstResponderTextField(
                            placeholder: viewModel.placeholderTitle,
                            text: $viewModel.fromText,
                            isActive: $viewModel.isFromTextActive,
                            activeBackgroundColor: viewModel.activeBackgroundColor,
                            activeTextColor: viewModel.activeTextColor,
                            inactiveBackgroundColor: viewModel.inactiveBackgroundColor,
                            inactiveTextColor: viewModel.inactiveTextColor)
                        Spacer().frame(width: 8)
                        TextOfEqualWidth(text: viewModel.fromTitle, minTextWidth: $textMinWidth)
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
                            placeholder: viewModel.placeholderTitle,
                            text: $viewModel.toText,
                            isActive: $viewModel.isToTextActive,
                            activeBackgroundColor: viewModel.activeBackgroundColor,
                            activeTextColor: viewModel.activeTextColor,
                            inactiveBackgroundColor: viewModel.inactiveBackgroundColor,
                            inactiveTextColor: viewModel.inactiveTextColor)
                        Spacer().frame(width: 8)
                        TextOfEqualWidth(text: viewModel.toTitle, minTextWidth: $textMinWidth)
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
        }
    }

}

struct ZoneSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        let zoneA = ResponseOperatorZone(id: "vt_a", resources: ["sv" : ["zone.title" : "Zon A"], "en" : ["zone.title" : "Zone A"]], sort: 0)
        let zoneB = ResponseOperatorZone(id: "vt_b", resources: ["sv" : ["zone.title" : "Zon B"], "en" : ["zone.title" : "Zone B"]], sort: 0)
        SelectZoneView(viewModel: SelectZoneViewModel(shoppingCart: ShoppingCart(ticketOperator: ProductsData.shared.data.operators.first!, product: ProductsData.shared.data.operators.first!.products!.first!), zones: [zoneA, zoneB]))
    }
}
